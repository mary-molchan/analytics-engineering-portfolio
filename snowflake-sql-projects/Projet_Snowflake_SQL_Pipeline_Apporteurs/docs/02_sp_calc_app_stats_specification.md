# Modele de specification SQL (format tableau)

## En-tete

| Titre | EPIN / Ticket | GitLab / Repo | Date de creation | Developpeur | Responsable du projet | Description fonctionnelle |
|---|---|---|---|---|---|---|
| Specification technique - sp_calc_app_stats | N/A | A completer | A completer | A completer | A completer | Procedure stockee de calcul de la liste des apporteurs avec indicateurs d'encours |

## Identification du script

| Champ | Valeur |
|---|---|
| Nom du script SQL | 02_sp_calc_app_stats.sql |
| Type de script | Procedure stockee |
| Nom objet principal (DB.Schema.Object) | DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_app_stats |
| Environnement cible | Dev / Test / Prod |
| Statut document | En revue |
| Confidentialite | Interne (identifiants deanonimises/generalises) |

## Architecture technique

| Champ | Valeur |
|---|---|
| Base de donnees | DEV_DB_INSURANCE |
| Schema de stockage | SC_SYNTH_INSURANCE |
| Warehouse / Compute | Non specifie dans ce script (defini via initialization/session) |
| Source(s) des donnees initiales (tables/views) | $contrgael_ea_j, $contrat, $situatcontr, $typesituat, $produit, $hierappcontr, $apporteur, $reseaudistrib |
| Langage (SQL, JavaScript) | SQL |
| Dependances (objets appeles) | Script de prerequis: initialization.sql |

## Parametres d entree

| Champ | Valeur |
|---|---|
| Nom | dt_partition, table_path |
| Type de donnees | NUMBER, STRING |
| Obligatoire (Oui / Non) | Oui / Oui |
| Valeur par defaut | Aucune |
| Description | dt_partition: partition AAAAMM; table_path: table cible pleinement qualifiee |
| Exemple d appel de procedure / requete | CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_app_stats(202505, 'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.LIST_APPORT'); |

### Tableau detaille des parametres (si plusieurs)

| Nom parametre | Type | Obligatoire | Defaut | Description metier/technique |
|---|---|---|---|---|
| dt_partition | NUMBER | Oui | Aucun | Partition de reference des donnees source (format AAAAMM) |
| table_path | STRING | Oui | Aucun | Chemin pleinement qualifie de la table de sortie a creer/alimenter |

## Donnees de sortie

| Champ | Type de donnees | Description des donnees |
|---|---|---|
| codapp | VARCHAR(16777216) | Code de l'apporteur |
| libnomapp | VARCHAR(16777216) | Nom de l'apporteur |
| codcompagnie | VARCHAR(16777216) | Code de la compagnie |
| codportefeuille | VARCHAR(16777216) | Code du portefeuille |
| reseaudistrib | VARCHAR(16777216) | Libelle du reseau de distribution |
| date_debut | DATE | Date de debut apporteur |
| nb_contrats | NUMBER(18,0) | Nombre total de contrats |
| nb_contrats_retraite | NUMBER(18,0) | Nombre de contrats retraite |
| nb_contrats_vie | NUMBER(18,0) | Nombre de contrats vie |
| ea | NUMBER(38,2) | Encours total |
| ea_pct_euro | NUMBER(38,2) | Pourcentage d'encours euro |
| ea_pct_uc | NUMBER(38,2) | Pourcentage d'encours UC |
| ea_uc | NUMBER(38,2) | Encours UC |
| ea_eu | NUMBER(38,2) | Encours euro |
| date_calcul | DATE | Date de calcul |

## Sources de donnees

| Source ID | Objet source (DB.Schema.Table/View) | Type | Criticite | Proprietaire |
|---|---|---|---|---|
| SRC-001 | identifier($contrgael_ea_j) | Table | Haute | A completer |
| SRC-002 | identifier($contrat) | Table | Haute | A completer |
| SRC-003 | identifier($situatcontr) | Table | Haute | A completer |
| SRC-004 | identifier($typesituat) | Table | Haute | A completer |
| SRC-005 | identifier($produit) | Table | Moyenne | A completer |
| SRC-006 | identifier($hierappcontr) | Table | Haute | A completer |
| SRC-007 | identifier($apporteur) | Table | Haute | A completer |
| SRC-008 | identifier($reseaudistrib) | Table | Moyenne | A completer |

## Logique de l implementation du script

1. Creer/remplacer la table cible `identifier(:table_path)` avec le schema de sortie.
2. Construire le CTE `ea_by_type` pour calculer l'encours par contrat (euro, UC, global).
3. Filtrer les sources sur `dt_partition` et conserver uniquement les contrats en vie (`indetatcontr = 2`).
4. Appliquer la validite temporelle des situations de contrat (`CURRENT_DATE` entre bornes ou annee 1830).
5. Joindre la hierarchie apporteur et les dimensions descriptives (apporteur, reseau).
6. Agreger par apporteur pour calculer volumes de contrats et indicateurs d'encours.
7. Inserer les resultats dans la table de sortie.
8. Retourner un message de succes d'alimentation.
9. Fin de procedure.

## Regles de calcul / transformation

| Regle ID | Description regle | Entrees | Sortie impactee |
|---|---|---|---|
| R-001 | Encours euro = somme conditionnelle `enummodges = 1` | contrgael_ea_j | ea_pct_euro, ea_eu |
| R-002 | Encours UC = somme conditionnelle `enummodges = 2` | contrgael_ea_j | ea_pct_uc, ea_uc |
| R-003 | Encours total = somme `mttotalfr` | contrgael_ea_j | ea |
| R-004 | Nombre contrats retraite/vie par filtre `codcompagnie` | ea_by_type + dimensions | nb_contrats_retraite, nb_contrats_vie |
| R-005 | Validite temporelle avec annee de fin conventionnelle 1830 | situatcontr/typesituat/hierappcontr | Perimetre final |

## Gestion des erreurs

| Cas d erreur | Detection | Action | Message retourne |
|---|---|---|---|
| Table source non resolue (variables session absentes) | Erreur SQL a l'execution | Echec execution | Message d'erreur Snowflake |
| Echec creation table cible | Erreur SQL DDL | Arret procedure | Message d'erreur Snowflake |
| Echec insertion/agregation | Erreur SQL DML | Arret procedure | Message d'erreur Snowflake |
| Execution nominale | Fin sans erreur | Retour succes | Le tableau <table_path> a ete mis a jour avec succes |

## Performance

| Champ | Valeur |
|---|---|
| Volumetrie estimee | A completer |
| Temps d execution cible | A completer |
| Strategie incrementalite / partitionnement | Filtrage par dt_partition |
| Points de vigilance performance | Jointures multiples + agrégations sur encours; cardinalite de numcontrat |

## Securite et conformite

| Champ | Valeur |
|---|---|
| Donnees sensibles traitees | Oui / A confirmer |
| Mecanismes de protection (masquage/anonymisation) | Identifiants deanonimises/generalises dans version portfolio |
| Principe du moindre privilege applique | A confirmer |
| Journalisation / audit | Non specifie dans ce script |

## Tests et validation

| ID test | Scenario | Donnees entree | Resultat attendu | Resultat obtenu | Statut |
|---|---|---|---|---|---|
| T-001 | Execution nominale | dt_partition=202505, table_path cible valide | Table creee et alimentee + message succes | A executer | A completer |
| T-002 | Partition sans donnees source | dt_partition hors plage | 0 ligne ou resultat selon source | A executer | A completer |
| T-003 | Session non initialisee | Variables $... non definies | Echec avec erreur source non resolue | A executer | A completer |

## Controle des versions

| Version | Date | Developpeur | Modifications |
|---|---|---|---|
| v0.1 | 2026-06-10 | A completer | Remplissage initial base sur 2 sp_calc_app_stats.sql |
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
