module Mathml2Tex

using EzXML
using CSV
using DataFrames

struct MathMLToLatexConverter
    mathml_node::EzXML.Node
end

include("unicode_to_tex.jl")


"""
    parse_mathml(converter::MathMLToLatexConverter)

Parse MathML node
"""
function parse_mathml(converter::MathMLToLatexConverter)
    return converter.mathml_node  # Retourne directement le nœud MathML
end


include("convert.jl")
include("files_processing.jl")

end

tei_files = [ 
    "path/to/file01.xml",
    "path/to/file02.xml"
]
Mathml2Tex.convert_mathml_to_csv(tei_files)
