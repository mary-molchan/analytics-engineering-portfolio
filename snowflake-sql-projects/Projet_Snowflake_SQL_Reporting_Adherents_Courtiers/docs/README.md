# Modele de specification SQL (format tableau)

## En-tete

| Titre | EPIN / Ticket | GitLab / Repo | Date de creation | Developpeur | Responsable du projet | Description fonctionnelle |
|---|---|---|---|---|---|---|
| Specification technique - Reporting Adherents Courtiers | N/A | A completer | 2026-06-10 | A completer | A completer | Procedure stockee de rafraichissement de la table de reporting adherents du perimetre courtiers |

## Identification du script

| Champ | Valeur |
|---|---|
| Nom du script SQL | Report adherents.sql |
| Type de script | Procedure stockee |
| Nom objet principal (DB.Schema.Object) | BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.PS_RAFRAICHIR_ADHERENTS_COURTIERS |
| Environnement cible | Dev / Test / Prod |
| Statut document | En revue |
| Confidentialite | Interne (version anonymisee/deanonimisee pour demonstration technique) |

## Architecture technique

| Champ | Valeur |
|---|---|
| Base de donnees | BD_ASSURANCE_DEMO |
| Schema de stockage | SC_PILOTAGE_COURTIERS |
| Warehouse / Compute | WH_ANALYSE_PARTAGE |
| Source(s) des donnees initiales (tables/views) | LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT, BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_ADHERENT, BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_CONVOCATION, BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.R_COURTIER |
| Langage (SQL, JavaScript) | SQL |
| Dependances (objets appeles) | Table cible RPT_ADHERENTS_COURTIERS; vues/sources contrat, adherent, convocation et courtier |

## Parametres d entree

| Champ | Valeur |
|---|---|
| Nom | Aucun |
| Type de donnees | N/A |
| Obligatoire (Oui / Non) | N/A |
| Valeur par defaut | N/A |
| Description | La procedure ne prend aucun parametre; la logique de perimetre temporel est calculee dynamiquement a l'execution |
| Exemple d appel de procedure / requete | CALL BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.PS_RAFRAICHIR_ADHERENTS_COURTIERS(); |

### Tableau detaille des parametres (si plusieurs)

| Nom parametre | Type | Obligatoire | Defaut | Description metier/technique |
|---|---|---|---|---|
| N/A | N/A | N/A | N/A | Procedure sans parametre d'entree |

## Donnees de sortie

| Champ | Type de donnees | Description des donnees |
|---|---|---|
| ID_ADHERENT | VARCHAR | Identifiant metier unique de l'adherent |
| LIB_CIVILITE | VARCHAR | Civilite normalisee issue du code source |
| NOM_ADHERENT | VARCHAR | Nom de l'adherent |
| PRENOM_ADHERENT | VARCHAR | Prenom de l'adherent |
| ADRESSE_LIGNE_1 | VARCHAR | Adresse principale |
| COMPLEMENT_ADRESSE | VARCHAR | Complement d'adresse |
| VILLE | VARCHAR | Ville de l'adherent |
| CODE_POSTAL | VARCHAR | Code postal valide sur 5 chiffres |
| CODE_DEPARTEMENT | VARCHAR | Code departement derive du code postal |
| COMMUNE | VARCHAR | Commune issue de la convocation |
| EMAIL_ADHERENT | VARCHAR | Adresse email de l'adherent |
| IND_EMAIL_PRESENT | VARCHAR | Indicateur Oui/Non de presence email |
| TELEPHONE_ADHERENT | VARCHAR | Telephone adherent |
| NUMERO_CONTRAT | VARCHAR | Numero du contrat |
| TYPE_PRODUIT | VARCHAR | Type/famille de produit |
| LIB_PRODUIT_ASSURANCE | VARCHAR | Libelle produit assurance |
| DATE_EFFET_CONTRAT | DATE | Date d'effet du contrat |
| DATE_FIN_CONTRAT | DATE | Date de fin du contrat |
| STATUT_CONTRAT | VARCHAR | Statut du contrat |
| ORIGINE_CONTRAT | VARCHAR | Origine/canal du contrat |
| NOM_COURTIER | VARCHAR | Nom du courtier associe |
| EMAIL_COURTIER | VARCHAR | Email du courtier |
| TELEPHONE_COURTIER | VARCHAR | Telephone prioritaire du courtier |
| INDICATEUR_NPAI | VARCHAR | Indicateur courrier non distribuable |
| BUREAU_DISTRIBUTION | VARCHAR | Bureau/agence de distribution |
| CODE_PERIMETRE | VARCHAR | Code de perimetre fixe: PERIM_COURTIER_ASTER |
| CLE_PARTITION | VARCHAR | Cle de partition AAAAMM |
| DATE_DERNIER_RAFRAICHISSEMENT | DATE | Date de chargement dans la table cible |

## Sources de donnees

| Source ID | Objet source (DB.Schema.Table/View) | Type | Criticite | Proprietaire |
|---|---|---|---|---|
| SRC-001 | LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT | Vue | Haute | A completer |
| SRC-002 | BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_ADHERENT | Vue | Haute | A completer |
| SRC-003 | BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_CONVOCATION | Vue | Moyenne | A completer |
| SRC-004 | BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.R_COURTIER | Table/Referentiel | Moyenne | A completer |
| SRC-005 | BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS | Table cible | Haute | A completer |

## Logique de l implementation du script

1. Initialiser le contexte de session (warehouse, database, schema, casse des identifiants).
2. Creer la table cible `RPT_ADHERENTS_COURTIERS` si elle n'existe pas avec le schema de sortie.
3. Supprimer les partitions de la cible qui sortent du perimetre historique dynamique de 5 ans.
4. Construire `src_adherent` avec une normalisation a une ligne par `NUMADHERENT` et filtrage qualite des codes postaux.
5. Construire `src_convocation` a une ligne par adherent (`N_ADH`) pour limiter les duplications.
6. Construire `src_courtier` a une ligne par `CDINTERMEDIAIRE` pour stabiliser le referentiel courtier.
7. Inserer les partitions absentes de la cible uniquement, via `NOT EXISTS` sur `CLE_PARTITION`.
8. Enrichir les donnees contrat avec les informations adherent, convocation et courtier, puis taguer le `CODE_PERIMETRE`.
9. Retourner un message applicatif de succes avec timestamp d'execution.

## Regles de calcul / transformation

| Regle ID | Description regle | Entrees | Sortie impactee |
|---|---|---|---|
| R-001 | Civilite normalisee: `01 -> M.` et `02 -> MME`, sinon NULL | V_ADHERENT.CDCIVILITE | LIB_CIVILITE |
| R-002 | Presence email derivee en `Oui/Non` selon nullite ou vide | V_ADHERENT.EMAIL | IND_EMAIL_PRESENT |
| R-003 | Telephone courtier priorise sur le fixe, puis mobile | R_COURTIER.TELFIXE, TELMOBILE | TELEPHONE_COURTIER |
| R-004 | Code departement derive des 2 premiers caracteres du code postal | V_ADHERENT.CDPOSTAL | CODE_DEPARTEMENT |
| R-005 | Filtre qualite: seulement codes postaux a 5 chiffres et departements `01` a `98` | V_ADHERENT.CDPOSTAL | Perimetre insere |
| R-006 | Code perimetre fixe pour segmentation aval | Constante | CODE_PERIMETRE |
| R-007 | Incrementalite par partition: insertion uniquement si `CLE_PARTITION` absente en cible | V_CONTRAT.DT_PARTITION + table cible | Perimetre charge |

## Gestion des erreurs

| Cas d erreur | Detection | Action | Message retourne |
|---|---|---|---|
| Source inaccessible ou objet absent | Erreur SQL lors d'un `SELECT`/`JOIN` | Arret de la procedure | Message d'erreur Snowflake |
| Echec DDL cible | Erreur SQL sur `CREATE TABLE IF NOT EXISTS` | Arret de la procedure | Message d'erreur Snowflake |
| Echec DML suppression/insertion | Erreur SQL sur `DELETE` ou `INSERT` | Arret de la procedure | Message d'erreur Snowflake |
| Donnees non conformes code postal | Filtre qualite SQL | Exclusion des lignes non conformes | Pas de message specifique; lignes ignorees |
| Execution nominale | Fin sans erreur | Retour succes | `Rafraichissement termine : <timestamp>` |

## Performance

| Champ | Valeur |
|---|---|
| Volumetrie estimee | A completer selon volumetrie contrat/adherent |
| Temps d execution cible | A completer |
| Strategie incrementalite / partitionnement | Chargement incremental par `CLE_PARTITION`; purge dynamique des partitions hors fenetre |
| Points de vigilance performance | `SELECT DISTINCT DT_PARTITION`, CTE de normalisation avec `MAX`, jointures sur referentiels et absence d'index logique sur sources volumineuses |

## Securite et conformite

| Champ | Valeur |
|---|---|
| Donnees sensibles traitees | Oui |
| Mecanismes de protection (masquage/anonymisation) | Noms d'objets et labels internes anonymises; aucune denomination reelle d'infrastructure conservee |
| Principe du moindre privilege applique | A confirmer |
| Journalisation / audit | Journalisation minimale via message de retour et date de rafraichissement par ligne |

## Tests et validation

| ID test | Scenario | Donnees entree | Resultat attendu | Resultat obtenu | Statut |
|---|---|---|---|---|---|
| T-001 | Lecture echantillon cible | Table cible alimentee | Requete `SELECT * LIMIT 100` sans erreur | A executer | A completer |
| T-002 | Controle volumetrie globale | Procedure executee | `NB_LIGNES > 0` | A executer | A completer |
| T-003 | Validation structure cible | Table cible creee | Colonnes attendues presentes | A executer | A completer |
| T-004 | Controle partitions hors perimetre | Partitions sources/cible | 0 ligne retournee | A executer | A completer |
| T-005 | Controle doublons complets | Cible alimentee | `NB_DOUBLONS_COMPLETS = 0` | A executer | A completer |
| T-006 | Controle doublons cle metier | Cible alimentee | 0 ligne retournee | A executer | A completer |
| T-007 | Completude incrementale | Partitions attendues vs cible | 0 partition manquante | A executer | A completer |
| T-008 | Nullite sur champs cles | Cible alimentee | Compteurs a 0 ou justifies | A executer | A completer |
| T-009 | Integrite du code perimetre | Cible alimentee | Une seule valeur `PERIM_COURTIER_ASTER` | A executer | A completer |

## Controle des versions

| Version | Date | Developpeur | Modifications |
|---|---|---|---|
| v0.1 | 2026-06-10 | A completer | Remplissage initial a partir de `Report adherents.sql` |
| v1.0 | YYYY-MM-DD |  | Validation initiale |

## Checklist de validation

- [x] Type de script clairement identifie (Procedure/View/CTE).
- [x] Entrees/sorties documentees.
- [x] Sources et dependances completes.
- [x] Logique d implementation detaillee.
- [x] Regles de calcul explicites.
- [x] Gestion des erreurs decrite.
- [x] Exigences securite et confidentialite precisees.
- [x] Criteres de performance renseignes.
- [x] Cas de tests documentes.
- [x] Versionning mis a jour.
