## En-tete

| Titre | EPIN / Ticket | GitLab / Repo | Date de creation | Developpeur | Responsable du projet | Description fonctionnelle |
|---|---|---|---|---|---|---|
| Specification technique - sp_calc_collect_app | N/A | A completer | A completer | A completer | A completer | Procedure stockee de calcul collectes/decollectes par apporteur |

## Identification du script

| Champ | Valeur |
|---|---|
| Nom du script SQL | 03_sp_calc_collect_app.sql |
| Type de script | Procedure stockee |
| Nom objet principal (DB.Schema.Object) | DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_collect_app |
| Environnement cible | Dev / Test / Prod |
| Statut document | En revue |
| Confidentialite | Interne (identifiants et codes deanonimises/generalises) |

## Architecture technique

| Champ | Valeur |
|---|---|
| Base de donnees | DEV_DB_INSURANCE |
| Schema de stockage | SC_SYNTH_INSURANCE |
| Warehouse / Compute | Non specifie dans ce script (defini via session/init) |
| Source(s) des donnees initiales (tables/views) | $compteclient, $lignecptcapi, $hierappcontr, $operation, $contr_ea_j |
| Langage (SQL, JavaScript) | SQL |
| Dependances (objets appeles) | Script de prerequis: initialization.sql + variable session optionnelle $codapp_scope |

## Parametres d entree

| Champ | Valeur |
|---|---|
| Nom | dt_partition, res_table_path, agi |
| Type de donnees | INT, STRING, STRING |
| Obligatoire (Oui / Non) | Oui / Oui / Oui |
| Valeur par defaut | Aucune |
| Description | dt_partition: partition AAAAMM; res_table_path: table de sortie; agi: conserve pour compatibilite |
| Exemple d appel de procedure / requete | CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_collect_app(202504, 'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SYN_SEI_COLLECTE', 'PRD'); |

### Tableau detaille des parametres (si plusieurs)

| Nom parametre | Type | Obligatoire | Defaut | Description metier/technique |
|---|---|---|---|---|
| dt_partition | INT | Oui | Aucun | Partition de traitement (AAAAMM) |
| res_table_path | STRING | Oui | Aucun | Table cible de sortie (fully qualified) |
| agi | STRING | Oui | Aucun | Parametre conserve pour compatibilite d'appel |

## Donnees de sortie

| Champ | Type de donnees | Description des donnees |
|---|---|---|
| codapp | STRING | Code apporteur |
| collecte | FLOAT | Montant total des flux entrants |
| decollecte | FLOAT | Montant total des flux sortants |
| ea | FLOAT | Encours consolide |
| annee | INT | Annee de reference |
| mois | INT | Mois de reference |
| codevecompta | STRING | Code evenement comptable (liste deanonimisee/generalisee) |
| dt_partition | INT | Partition technique de traitement |
| date_calcul | DATE | Date d'execution du calcul |

## Sources de donnees

| Source ID | Objet source (DB.Schema.Table/View) | Type | Criticite | Proprietaire |
|---|---|---|---|---|
| SRC-001 | identifier($compteclient) | Table | Haute | A completer |
| SRC-002 | identifier($lignecptcapi) | Table | Haute | A completer |
| SRC-003 | identifier($hierappcontr) | Table | Haute | A completer |
| SRC-004 | identifier($operation) | Table | Haute | A completer |
| SRC-005 | identifier($contr_ea_j) | Table | Haute | A completer |

## Logique de l implementation du script

1. Creer la table cible si elle n'existe pas (schema de sortie standardise).
2. Construire `tmp_flux` via CTE `raw_ops` sur les mouvements et lignes de capitalisation.
3. Classer chaque flux en entrant/sortant selon le signe de `mt_operation`.
4. Calculer `mt_brut` et `mt_net` selon la nature du flux.
5. Filtrer les donnees (partition, codes evenements anonymises, periode, codapp_scope optionnel).
6. Supprimer de `tmp_flux` les operations annulees et annulantes.
7. Fusionner (MERGE) les aggregats dans la table cible par codapp/annee/mois/codevecompta.
8. Mettre a jour l'encours `ea` depuis `contr_ea_j` avec validite hierarchique.
9. Retourner un message de succes.

## Regles de calcul / transformation

| Regle ID | Description regle | Entrees | Sortie impactee |
|---|---|---|---|
| R-001 | type_flux = sortant si mt_operation < 0, entrant si > 0 | compteclient | type_flux |
| R-002 | collecte = somme mt_brut sur flux entrants | tmp_flux | collecte |
| R-003 | decollecte = somme mt_net sur flux sortants | tmp_flux | decollecte |
| R-004 | exclusion operations annulees/annulantes via table operation | tmp_flux + operation | perimetre final |
| R-005 | ea = somme mttotalfr par codapp/mois/annee | contr_ea_j + hierappcontr | ea |

## Gestion des erreurs

| Cas d erreur | Detection | Action | Message retourne |
|---|---|---|---|
| Variables session non initialisees | Erreur SQL identifier($...) | Arret procedure | Message d'erreur Snowflake |
| Echec DDL/DML (create temp/merge/update) | Erreur SQL execution | Arret procedure | Message d'erreur Snowflake |
| Execution nominale | Fin sans erreur | Retour succes | Table des collectes est mise a jour avec succes |

## Performance

| Champ | Valeur |
|---|---|
| Volumetrie estimee | A completer |
| Temps d execution cible | A completer |
| Strategie incrementalite / partitionnement | Filtrage par dt_partition |
| Points de vigilance performance | CTE + agrégations + MERGE + update EA |

## Securite et conformite

| Champ | Valeur |
|---|---|
| Donnees sensibles traitees | Oui / A confirmer |
| Mecanismes de protection (masquage/anonymisation) | Identifiants/codes evenements deanonimises/generalises |
| Principe du moindre privilege applique | A confirmer |
| Journalisation / audit | Non specifie dans ce script |

## Tests et validation

| ID test | Scenario | Donnees entree | Resultat attendu | Resultat obtenu | Statut |
|---|---|---|---|---|---|
| T-001 | Execution nominale | dt_partition valide + table cible valide | Table creee/mise a jour + message succes | A executer | A completer |
| T-002 | Partition hors perimetre | dt_partition sans donnees | 0/peu de lignes selon source | A executer | A completer |
| T-003 | codapp_scope specifique | codapp_scope renseigne | Sortie filtree au codapp | A executer | A completer |

## Controle des versions

| Version | Date | Developpeur | Modifications |
|---|---|---|---|
| v0.1 | 2026-06-10 | A completer | Remplissage initial base sur 03_sp_calc_collect_app.sql |
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
