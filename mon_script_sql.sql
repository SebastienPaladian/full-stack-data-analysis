Partie 3 – Test SQL


Exercices SQL : 1. Chiffre d'affaires et marge par région Calculez le total des ventes (montant) et la marge (marge) agrégés par région (depuis la table clients liée à ventes).

SELECT c.region, SUM(v.montant) AS Chiffre_affaires_total, SUM(v.marge) AS Marge_totale
FROM ventes AS v
INNER JOIN client AS c
ON v.id_client = c.id_client
GROUP BY c.region ;

2. Top 5 des clients
Affichez les 5 clients ayant généré le plus de chiffre d’affaires.

SELECT c.id_client, c.nom_client, SUM (v.montant) AS Chiffre_affaires
FROM ventes AS v
INNER JOIN clients AS c
ON v.id_client = c.id_client
GROUP BY  c.id_client, c.nom_client
ORDER BY Chiffre_affaires DESC
LIMIT 5;

3. Évolution mensuelle des ventes en 2023 
Affichez le chiffre d'affaires par mois pour l'année 2023, avec regroupement par mois.

SELECT EXTRACT (MONTH FROM v.date_vente) AS Mois, SUM (v.montant) AS Chiffre_affaires
FROM ventes AS v
WHERE EXTRACT (YEAR FROM v.date_vente) = 2023
GROUP by Mois
ORDER by Mois ASC;
4. Répartition du chiffre d’affaires par catégorie de produit 
Affichez le CA par catégorie (table produits), trié du plus élevé au plus faible.

SELECT p.categorie, SUM(v.montant) AS Chiffre_affaires
FROM ventes as v
INNER JOIN produit AS p
ON v.id_produit = p.id_produit
GROUP BY p.categorie
ORDER BY Chiffre_affaires DESC;


5. Analyse budgétaire 2020 par ville Rejoignez les ventes de 2020 aux villes (si ville = région) et comparez les revenus réels au budget (valeurs, var € et %).

SELECT b.ville, SUM(v.montant) AS Chiffre_affaires_2020, b.budget_2020,
	SUM(v.montant) - b.budget_2020 AS variation_euros,
ROUND(100.0 * (SUM(v.montant) - b.budget_2020) / b.budget_2020,2) AS  variation_pourcent	
FROM ventes AS v
INNER JOIN clients AS c
ON v.id_client = c.id_client 
INNER JOIN budget AS b
ON c.region = b.ville
WHERE EXTRACT (YEAR FROM date.vente) = 2020
GROUP BY b.ville
ORDER BY b.ville





