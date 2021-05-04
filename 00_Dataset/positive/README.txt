Files
--------------------------------------------
swissprot_human_secreted.fasta             human secretory protein sequences
                                           (Subcellular location name:"Secreted") in 
                                           SwissProt database.
swissprot_human_secreted.tab               human secretory proteins in SwissProt database 
                                           in table format.
query_secreted.txt                         list of filtered human secretory proteins from
                                           'human_secreted_proteins_filtered.xlsx'.
output_secreted.fasta                      Retrieved secretory protein sequences


Extracting human protein sequences
--------------------------------------------
Positive subset:
	1. Search based on subcellular location
	2. Search for keyword "Secreted"
	3. Select only protein from SwissProt database
	4. Select proteins only from human (total: 2,088 proteins retrieved on 13 Apr 2021)
	5. Export data in fasta and table format
		- table must include subcellular location column
	6. Specific location terms to exculde: "membrane", "endoplasmic reticulum" and "nucleus"
	7. Exclude records shorter than or equal to 100 aa
	8. Exclude records with keywords "uncharacterized","probable", "putative"
		"fragment" keyword found in preproprotein that report the mature peptides is allowed,
		N- and C-terminal "fragment" is not allowed 
	   (total remain: 805 proteins on 16 Apr 2021)
	9. Exclude records that not containing the evidence code
	6. Manipulate fasta header as
		|----------------------|
	    | >accession|location  |
	    |----------------------|