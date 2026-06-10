## Spécifications du script de la procédure stockée SP_MAJ_APPORT_PARTCALC

| Titre | EPIN / Ticket | GitLab / Repo | Date de creation | Developpeur | Responsable du projet | Description fonctionnelle |
|---|---|---|---|---|---|---|
| Specification technique - SP_MAJ_APPORT_PARTCALC | N/A | A completer | A completer | A completer | A completer | Procedure orchestratrice de mise a jour apporteurs/collectes |

## Identification du script

| Champ | Valeur |
|---|---|
| Nom du script SQL | 04_sp_orchestrate_apporteurs.sql |
| Type de script | Procedure stockee |
| Nom objet principal (DB.Schema.Object) | DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SP_MAJ_APPORT_PARTCALC |
| Environnement cible | Dev / Test / Prod |
| Statut document | En revue |
| Confidentialite | Interne (identifiants deanonimises/generalises) |

## Architecture technique

| Champ | Valeur |
|---|---|
| Base de donnees | DEV_DB_INSURANCE |
| Schema de stockage | SC_SYNTH_INSURANCE |
| Warehouse / Compute | WH_SHARED_ANALYTICS (dans le script de creation) |
| Source(s) des donnees initiales (tables/views) | identifier($apporteur) + variables session sources resolues |
| Langage (SQL, JavaScript) | SQL |
| Dependances (objets appeles) | sp_calc_collect_app, sp_calc_app_stats |

## Parametres d entree

| Champ | Valeur |
|---|---|
| Nom | Aucun |
| Type de donnees | N/A |
| Obligatoire (Oui / Non) | N/A |
| Valeur par defaut | N/A |
| Description | Partition calculee automatiquement a partir de CURRENT_DATE |
| Exemple d appel de procedure / requete | CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SP_MAJ_APPORT_PARTCALC(); |

### Tableau detaille des parametres (si plusieurs)

| Nom parametre | Type | Obligatoire | Defaut | Description metier/technique |
|---|---|---|---|---|
| N/A | N/A | N/A | N/A | Procedure sans parametre |

## Donnees de sortie

| Champ | Type de donnees | Description des donnees |
|---|---|---|
| timestamp_exec | TIMESTAMP_LTZ | Horodatage de fin d'execution |
| statut | VARCHAR | Statut global (SUCCES COMPLET ou message d'erreur) |
| duree_execution | VARCHAR | Duree formatee en minutes/secondes |
| execute_par | VARCHAR | Utilisateur Snowflake ayant lance la procedure |
| role_actif | VARCHAR | Role actif pendant l'execution |
| periode_traitee | NUMBER(38,0) | Partition traitee (AAAAMM) ; en cas d'absence source: valeur retournee = partition calculee - 1 |

## Sources de donnees

| Source ID | Objet source (DB.Schema.Table/View) | Type | Criticite | Proprietaire |
|---|---|---|---|---|
| SRC-001 | identifier($apporteur) | Table | Haute | A completer |
| SRC-002 | sp_calc_collect_app | Procedure | Haute | A completer |
| SRC-003 | sp_calc_app_stats | Procedure | Haute | A completer |

## Logique de l implementation du script

1. Initialiser le contexte de session (database/schema) pour l'execution.
2. Calculer la partition courante `calculated_partition = YEAR(CURRENT_DATE())*100 + MONTH(CURRENT_DATE())`.
3. Initialiser les variables de session partagees (env, schemas source, chemins de tables).
4. Resoudre le prefixe source selon env (PRD/REC).
5. Construire les variables des tables source mutualisees pour les procedures filles.
6. Verifier la presence de donnees source apporteur pour la partition calculee.
7. En cas d'absence de donnees, retourner un statut d'erreur sans lancer les calculs metier.
8. Demarrer le chronometre et appeler successivement `sp_calc_collect_app` puis `sp_calc_app_stats`.
9. Retourner un resultat de succes avec metriques d'execution (timestamp, duree, user, role, partition).

## Regles de calcul / transformation

| Regle ID | Description regle | Entrees | Sortie impactee |
|---|---|---|---|
| R-001 | Partition automatiquement calculee sur le mois courant (AAAAMM) | CURRENT_DATE | periode_traitee |
| R-002 | Arret anticipe si aucune donnee source apporteur pour la partition, avec retour periode_traitee = partition - 1 | table apporteur | statut, periode_traitee |
| R-003 | Orchestration sequentielle des procedures filles | sp_calc_collect_app + sp_calc_app_stats | donnees cibles mises a jour |
| R-004 | Duree calculee via DATEDIFF puis formattee en "X min Y sec" | start_time/end_time | duree_execution |

## Gestion des erreurs

| Cas d erreur | Detection | Action | Message retourne |
|---|---|---|---|
| Aucune donnee source pour partition courante | COUNT(*) = 0 sur identifier($apporteur) | Arret orchestration | ERREUR: Aucune donnee source pour la partition ... |
| Echec procedure fille (collect/app_stats) | Erreur SQL lors des CALL | Arret procedure | Message d'erreur Snowflake |
| Echec initialisation variables session | Erreur SQL SET/identifier | Arret procedure | Message d'erreur Snowflake |
| Execution nominale | Fin sans erreur | Retour succes | SUCCES COMPLET |

## Performance

| Champ | Valeur |
|---|---|
| Volumetrie estimee | Dependant des procedures filles |
| Temps d execution cible | A completer |
| Strategie incrementalite / partitionnement | Pilotage par partition courante |
| Points de vigilance performance | Cout global = somme des 2 procedures filles + validation source |

## Securite et conformite

| Champ | Valeur |
|---|---|
| Donnees sensibles traitees | Oui / A confirmer |
| Mecanismes de protection (masquage/anonymisation) | Identifiants deanonimises/generalises dans version portfolio |
| Principe du moindre privilege applique | A confirmer |
| Journalisation / audit | Metadonnees de retour (user/role/timestamp) |

## Tests et validation

| ID test | Scenario | Donnees entree | Resultat attendu | Resultat obtenu | Statut |
|---|---|---|---|---|---|
| T-001 | Execution nominale | Donnees source presentes pour partition courante | SUCCES COMPLET + procedures filles executees | A executer | A completer |
| T-002 | Absence donnees source | Partition sans donnees apporteur | Retour erreur fonctionnelle + arret orchestration | A executer | A completer |
| T-003 | Echec procedure fille | Simuler erreur dans sp_calc_collect_app | Arret avec erreur SQL | A executer | A completer |

## Controle des versions

| Version | Date | Developpeur | Modifications |
|---|---|---|---|
| v0.1 | 2026-06-10 | A completer | Remplissage initial base sur 04_sp_orchestrate_apporteurs.sql |
| v1.0 | YYYY-MM-DD |  | Validation initiale |

## Checklist de validation

- [x] Type de script clairement identifie (Procedure/View/CTE).
- [x] Entrees/sorties documentees.
- [x] Sources et dependances completes.
- [x] Logique d implementation detaillee.
- [x] Regles de calcul explicites.
- [x] Gestion des erreurs decrite.
- [x] Exigences securite et confidentialite precisees.
- [ ] Criteres de performance renseignes.
- [ ] Cas de tests documentes.
- [x] Versionning mis a jour.
