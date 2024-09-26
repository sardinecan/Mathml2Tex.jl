"""
    unicode_to_latex 

Unicode to latex mapping dictionary
"""
const unicode_to_latex = Dict(
    # Lettres grecques majuscules
    'Α' => "\\Alpha ",
    'Β' => "\\Beta ",
    'Γ' => "\\Gamma ",
    'Δ' => "\\Delta ",
    'Ε' => "\\Epsilon ",
    'Ζ' => "\\Zeta ",
    'Η' => "\\Eta ",
    'Θ' => "\\Theta ",
    'Ι' => "\\Iota ",
    'Κ' => "\\Kappa ",
    'Λ' => "\\Lambda ",
    'Μ' => "\\Mu ",
    'Ν' => "\\Nu ",
    'Ξ' => "\\Xi ",
    'Ο' => "\\Omicron ",
    'Π' => "\\Pi ",
    'Ρ' => "\\Rho ",
    'Σ' => "\\Sigma ",
    'Τ' => "\\Tau ",
    'Υ' => "\\Upsilon ",
    'Φ' => "\\Phi ",
    'Χ' => "\\Chi ",
    'Ψ' => "\\Psi ",
    'Ω' => "\\Omega ",

    # Lettres grecques minuscules
    'α' => "\\alpha ",
    'β' => "\\beta ",
    'γ' => "\\gamma ",
    'δ' => "\\delta ",
    'ε' => "\\epsilon ",
    'ζ' => "\\zeta ",
    'η' => "\\eta ",
    'θ' => "\\theta ",
    'ι' => "\\iota ",
    'κ' => "\\kappa ",
    'λ' => "\\lambda ",
    'μ' => "\\mu ",
    'ν' => "\\nu ",
    'ξ' => "\\xi ",
    'ο' => "\\omicron ",
    'π' => "\\pi ",
    'ρ' => "\\rho ",
    'σ' => "\\sigma ",
    'τ' => "\\tau ",
    'υ' => "\\upsilon ",
    'φ' => "\\phi ",
    'χ' => "\\chi ",
    'ψ' => "\\psi ",
    'ω' => "\\omega ",

    # Opérateurs de dérivées et sommes
    '∂' => "\\partial ",
    '∑' => "\\sum ",
    '∏' => "\\prod ",
    '∫' => "\\int ",
    '∮' => "\\oint ",
    '∇' => "\\nabla ",

    # Opérateurs logiques et relationnels
    '≠' => "\\neq ",
    '≈' => "\\approx ",
    '≡' => "\\equiv ",
    '≥' => "\\geq ",
    '≤' => "\\leq ",
    '∝' => "\\propto ",
    '→' => "\\to ",
    '←' => "\\leftarrow ",
    '⇒' => "\\Rightarrow ",
    '⇐' => "\\Leftarrow ",
    '⇔' => "\\Leftrightarrow ",

    # Symboles infini et appartenance
    '∞' => "\\infty ",
    '∈' => "\\in ",
    '∉' => "\\notin ",
    '⊆' => "\\subseteq ",
    '⊂' => "\\subset ",
    '⊇' => "\\supseteq ",
    '⊃' => "\\supset ",

    # Symboles algébriques et géométriques
    '√' => "\\sqrt ",
    '∛' => "\\sqrt[3] ",
    '∜' => "\\sqrt[4] ",

    # Opérateurs binaires et booléens
    '⊕' => "\\oplus ",
    '⊗' => "\\otimes ",
    '⊙' => "\\odot ",
    '⋅' => "\\cdot ",
    '×' => "\\times ",
    '÷' => "\\div ",
    '∧' => "\\land ",
    '∨' => "\\lor ",
    '⊻' => "\\veebar ",
    '¬' => "\\neg ",

    # Ensemble et logique
    '∅' => "\\emptyset ",
    '∀' => "\\forall ",
    '∃' => "\\exists ",
    '⊤' => "\\top ",
    '⊥' => "\\perp ",

    # Ensemble des nombres
    'ℕ' => "\\mathbb{N} ",
    'ℤ' => "\\mathbb{Z} ",
    'ℚ' => "\\mathbb{Q} ",
    'ℝ' => "\\mathbb{R} ",
    'ℂ' => "\\mathbb{C} ",

    # Signes moins et tirets
    '−' => "-",
    '‒' => "--",  # tiret court
    '–' => "--",  # demi-cadratin (tiret moyen)
    '—' => "---", # tiret cadratin (long)

    # Parenthèses et autres délimiteurs
    '⟨' => "\\langle ",
    '⟩' => "\\rangle ",
    '|'  => "\\mid ",
    '‖' => "\\parallel ",
    '⌊' => "\\lfloor ",
    '⌋' => "\\rfloor ",
    '⌈' => "\\lceil ",
    '⌉' => "\\rceil ",

    # Autres symboles
    '′' => "\\prime ",
    '″' => "\\doubleprime ",
    '∴' => "\\therefore ",
    '∵' => "\\because ",
    '∠' => "\\angle ",
    '⊥' => "\\perp ",
    '⋀' => "\\bigwedge ",
    '⋁' => "\\bigvee ",

    # Points de suspension
    '⋯' => "\\cdots ",
    '⋮' => "\\vdots ",
    '⋱' => "\\ddots ",
    '…' => "\\ldots ",  # Trois points en ligne
    '∘' => "\\circ ",   # Point médian (cercle)

    # Points médiants et séparateurs
    '·' => "\\cdot ",  # Point centré (dot)
    '⨼' => "\\bigsqcap ",  # Point séparateur
    '⨽' => "\\bigsqcup ",  # Point séparateur union
)


"""
    replace_unicode_with_latex(text::String)

Replace Unicode char with LaTeX symbol in `text`.
"""
function replace_unicode_with_latex(text::String)
    for (unicode_char, latex_symbol) in unicode_to_latex
        text = replace(text, unicode_char => latex_symbol)
    end
    return text
end

