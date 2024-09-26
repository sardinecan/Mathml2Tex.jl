"""
    process_tei_file(file_path::String, latex_formulas::Vector{String})

extracts mathematical formulas from a TEI file and sends the formulas for conversion
"""
function process_tei_file(file_path::String, latex_formulas::Vector{String})
    println("Processing file: $file_path")
    try
        content = readxml(file_path)
        ns = namespace(content.root)

        # Parser le document XML
        root = EzXML.root(content)

        # Trouver toutes les formules dans l'espace de nom TEI
        formula_nodes = findall("//tei:formula", root, ["tei"=>ns])
        
        if isempty(formula_nodes)
            println("No <formula> nodes found in $file_path.")
            return
        end
        
        for formula in formula_nodes
            # Trouver le nœud <math> à l'intérieur de <formula>
            mathml_node = EzXML.firstelement(formula)
            if mathml_node !== nothing && mathml_node.name == "math" && EzXML.namespace(mathml_node) == "http://www.w3.org/1998/Math/MathML"
                # Debug: afficher le contenu du nœud math
                println("Found MathML: ", EzXML.nodecontent(mathml_node))

                # Convertir le MathML en LaTeX
                converter = MathMLToLatexConverter(mathml_node)
                latex_formula = convert(converter)

                # Debug: afficher la formule LaTeX générée
                println("Converted LaTeX: ", latex_formula)

                # Ajouter la formule LaTeX à la liste
                push!(latex_formulas, latex_formula)
            else
                println("No <math> node found inside <formula> in $file_path or namespace mismatch.")
            end
        end
    catch e
        println("Erreur lors du traitement du fichier $file_path: ", e)
    end
end


"""
    convert_mathml_to_csv(tei_files::Vector{String})

processes TEI files and writes converted formulas to CSV files
"""
function convert_mathml_to_csv(tei_files::Vector{String})
  for tei_file in tei_files
    # Créer un tableau pour stocker les formules LaTeX
    latex_formulas = String[]
    process_tei_file(tei_file, latex_formulas)

    # Écrire les formules LaTeX dans un fichier CSV
    if !isempty(latex_formulas)
      df = DataFrame(formula=latex_formulas)
      CSV.write(splitext(tei_file)[1]*".csv", df)
      println("CSV file generated: ", splitext(tei_file)[1]*".csv")
    else
      println("No formulas found to write to CSV.")
    end
  end
end

