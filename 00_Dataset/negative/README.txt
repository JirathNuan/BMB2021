Files
--------------------------------------------
swissprot_human_mitochondrion-matrix.fasta            human mitochondrial protein sequences
                                                      (Subcellular location name:"Mitochondrion") in 
                                                      SwissProt database.
swissprot_human_mitochondrion-matrix.tab              human mitochondrial proteins in SwissProt 
                                                      database in table format.
query_mitochondrion-matrix.txt                        list of filtered human secretory proteins
output_mitochondrion-matrix.fasta                     Retrieved mitochondrial protein sequences

swissprot_human_cell-envelope.fasta                   human mitochondrial protein sequences
                                                      (Subcellular location name:"Mitochondrion") 
                                                      in SwissProt database.
swissprot_human_cell-envelope.tab                     human mitochondrial proteins in SwissProt 
                                                      database in table format.
query_cell-envelope.txt                               list of filtered human secretory proteins 
                                                      from 'human_secreted_proteins_filtered.xlsx'.
output_cell-envelope.fasta				              Retrieved multi-pass transmembrane protein 
                                                      sequences


Extracting human protein sequences
--------------------------------------------
Negative subset:
	1. Search based on subcellular location
	2. Search for location name
		- For mitochondrion, search "mitochondrion matrix"
		- For cell membrane, search "cell envelope"
	3. Select only protein from SwissProt database
	4. Select proteins only from human 
			- Mitochondrion matrix: 193 proteins retrieved on 16 Apr 2021
			- Cell envelope: 3,755 proteins retrieved on 16 Apr 2021
	5. Export data in fasta and table format
		- table must include subcellular location column
	6. Specific location terms to exculde:
		Mitochondrion:
			Select protein sequences that containing only one location of interest or may containing similar location e.g. mitochondrion matrix with mitochondrion is acceptable
		Cell envelope:
			Exclude proteins that can located more than one different location such as "secreted","cytoplasm","endoplasmic reticulum","nucleus","peroxisome","virion","mitochondrion","lysosome", and "golgi"
	7. Exclude records that have no evidence code
	8. Exclude records shorter than or equal to 100 aa
	9. Exclude records with keywords 
		- "uncharacterized"
		- "probable"
		- "similar"
		- "fragment" keyword found in preproprotein that report the mature peptides is allowed,
		- N- and C-terminal "fragment" is not allowed
		- fragmented protein is not allowed
	6. Manipulate fasta header as
		|----------------------|
	    | >accession|location  |
	    |----------------------|



Summary
--------------------------------------------

| subcellular locations | # original | # filtered |
|-----------------------|------------|------------|
| Mitochondrion matrix  |    193     |     90     |
| Cell envelope         |    3755    |    1237    |

