"""
    convert_to_latex(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Parse and convert MathML nodes.
"""
function convert_to_latex(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    tag = element.name
    
    # Vérifie si le tag est dans le dictionnaire de correspondance
    if haskey(tag_to_latex, tag)
        return tag_to_latex[tag](element, tag_to_latex)
    else
        # Si pas de correspondance, on traite les enfants récursivement
        latex = ""
        for child in EzXML.nodes(element)  # Utilisation de nodes
            latex *= convert_to_latex(child, tag_to_latex)
        end
        return latex
    end
end


"""
    convert_fraction(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Convert `<mfrac>` tag to corresponding LaTeX symbol.
"""
function convert_fraction(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    numerator = convert_to_latex(EzXML.firstelement(element), tag_to_latex)
    denominator = convert_to_latex(EzXML.lastelement(element), tag_to_latex)
    return "\\frac{$numerator}{$denominator}"
end


"""
    convert_superscript(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Convert `<msup>` tag to corresponding LaTeX symbol.
"""
function convert_superscript(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    base = convert_to_latex(EzXML.firstelement(element), tag_to_latex)
    exponent = convert_to_latex(EzXML.lastelement(element), tag_to_latex)
    return "$base^{$exponent}"
end


"""
    convert_subscript(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Convert `<msub>` tag to corresponding LaTeX symbol.
"""
function convert_subscript(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    base = convert_to_latex(EzXML.firstelement(element), tag_to_latex)
    subscript = convert_to_latex(EzXML.lastelement(element), tag_to_latex)
    return "$base_{$subscript}"
end


"""
    convert_sqrt(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Convert `<msqrt>` tag to corresponding LaTeX symbol.
"""
function convert_sqrt(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    radicand = convert_to_latex(EzXML.firstelement(element), tag_to_latex)
    return "\\sqrt{$radicand}"
end


"""
    convert_identifier(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Convert the content of `<mi>` (identifier) node to LaTeX.
"""
function convert_identifier(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    content = EzXML.nodecontent(element)
    return replace_unicode_with_latex(content)  # Remplacer les caractères Unicode
end


"""
    convert_number(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Convert the content of `<mn>` (number) node to LaTeX.
"""
function convert_number(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    content = EzXML.nodecontent(element)
    return replace_unicode_with_latex(content)  # Remplacer les caractères Unicode
end


"""
    convert_operator(element::EzXML.Node, tag_to_latex::Dict{String, Function})

Convert the content of `<mo>` (operator) node to LaTeX.
"""
function convert_operator(element::EzXML.Node, tag_to_latex::Dict{String, Function})
    content = EzXML.nodecontent(element)
    return replace_unicode_with_latex(content)  # Remplacer les caractères Unicode
end


"""
    convert(converter::MathMLToLatexConverter)

Mapping function to convert MathML tags to LaTeX.
"""
function convert(converter::MathMLToLatexConverter)
    # Étape 1: Parsing du MathML (n'est plus nécessaire car on utilise le nœud directement)
    mathml_tree = parse_mathml(converter)
    
    # Étape 2: Mapping des balises MathML vers les fonctions LaTeX correspondantes
    tag_to_latex = Dict(
        "mfrac" => convert_fraction,
        "msup" => convert_superscript,
        "msub" => convert_subscript,
        "msqrt" => convert_sqrt,
        "mi" => convert_identifier,
        "mn" => convert_number,
        "mo" => convert_operator
    )
    
    # Étape 3: Conversion du MathML en LaTeX
    latex_output = convert_to_latex(mathml_tree, tag_to_latex)
    
    return latex_output
end

