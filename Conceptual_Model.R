#Conceptual Model

library(decisionSupport)
library(DiagrammeR)



DiagrammeR('graph LR
           B(overall_benefits)-->A(result)
           C(benefits_agroforestry)-->B
           I(Ecosystem Service)-->C
           A2(Shading Effect)-->C
           J(Subsidies)-->C
           N(Investment Cost)-->C
           T(Hired Labour)-->N
           U(Seed)-->N
           V(Machinery)-->N
           W(Plant protection)-->N
           X(Manures and fertilizers)-->N
           O(Annual cost)-->P
           S(Maintenance Cut)-->O
           P(Profit Margin)-->C
           Q(Margin Wood)-->P
           R(Harvesting Cost)-->P
           D(benefits_agripv)-->B
           A3(Shading Effect)-->D
           J2(Subsidies)-->D
           Y(Investment Cost)-->Z
           G(Cost of Panels)-->Y
           H(Hired Labour)-->Y
           Z(Profit Margin)-->D
           E(Profit through Energy )-->Z
           F(Annual cost)-->Z
           K(benefits_crops)-->B
           L(costs_more_cultivation)-->K
           M(income_more_cultivation)-->K
           varA(AV variables)
           varB(Standard farm variables)
           varC(Risks)
           varD(not included yet)
           style PVA fill:orange, stroke:#333,stroke-width:2px;
           style varA fill:orange, stroke:#333,stroke-width:4px;
           style varB stroke:#333,stroke-width:4px;
           style varC fill:gray, stroke:#333,stroke-width:4px;
           style varD fill:green, stroke:#333,stroke-width:4px;')