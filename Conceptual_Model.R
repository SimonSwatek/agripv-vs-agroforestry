#Conceptual Model

library(decisionSupport)
library(DiagrammeR)




DiagrammeR('graph LR
           B(Overall benefits)-->A(result)
           B2(Type of panel)-->G
           C((Benefits agroforestry))-->B
           I(Ecosystem Service)-->C
           A4(PAR Radiation)-->E
           J(Subsidies)-->C
           N(Investment Cost)-->P
           T(Hired Labour)-->N
           U(Transplants)-->N
           V(Machinery)-->N
           W(Plant protection)-->N
           X(Manures and fertilizers)-->N
           O(Annual cost)-->P
           S(Maintenance cut)-->O
           P(Profit margin)-->C
           Q(Wood yield)-->P
           R(Harvesting cost)-->P
           D((Benefits agripv))-->B
           J2(Subsidies)-->D
           Y(Investment cost)-->Z
           G(Cost of panels)-->Y
           H(Hired labour)-->G
           Z(Profit margin)-->D
           E(Profit through energy )-->Z
           F(Annual cost)-->Z
           K((Benefits crops))-->B
           M(Conventional yield)-->K
           L1(Yield loss)-->P
           L2(Yield loss)-->Z
           P1(Extreme weather event)-->C
           P1(Extreme weather event)-->D
           P1(Extreme weather event)-->K
           H1(High price fluctation)-->P
           H2(High price fluctation)-->Z
           A5(Social Acceptance)-->C
           A5(Social Acceptance)-->D
           varB(costs)
           varC(Risks)
           varD(profits)
           style P1  fill:yellow, stroke:#333,stroke-width:2px;
           style H1  fill:yellow, stroke:#333,stroke-width:2px;
           style H2  fill:yellow, stroke:#333,stroke-width:2px;
           style A5  fill:yellow, stroke:#333,stroke-width:2px;
           style I  fill:lightgreen, stroke:#333,stroke-width:2px;
           style J  fill:lightgreen, stroke:#333,stroke-width:2px;
           style Q  fill:lightgreen, stroke:#333,stroke-width:2px;
           style J2  fill:lightgreen, stroke:#333,stroke-width:2px;
           style E  fill:lightgreen, stroke:#333,stroke-width:2px;
           style M  fill:lightgreen, stroke:#333,stroke-width:2px;
           style B2  fill:lightcoral, stroke:#333,stroke-width:2px;
           style T  fill:lightcoral, stroke:#333,stroke-width:2px;
           style U  fill:lightcoral, stroke:#333,stroke-width:2px;
           style V  fill:lightcoral, stroke:#333,stroke-width:2px;
           style X  fill:lightcoral, stroke:#333,stroke-width:2px;
           style S  fill:lightcoral, stroke:#333,stroke-width:2px;
           style R  fill:lightcoral, stroke:#333,stroke-width:2px;
           style G  fill:lightcoral, stroke:#333,stroke-width:2px;
           style H  fill:lightcoral, stroke:#333,stroke-width:2px;
           style L1  fill:lightcoral, stroke:#333,stroke-width:2px;
           style L2 fill:lightcoral, stroke:#333,stroke-width:2px;
           style F  fill:lightcoral, stroke:#333,stroke-width:2px;
           style O  fill:lightcoral, stroke:#333,stroke-width:2px;
           style W  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N  fill:lightcoral, stroke:#333,stroke-width:2px;
           style Y  fill:lightcoral, stroke:#333,stroke-width:2px;
           style varB fill:lightcoral, stroke:#333,stroke-width:4px;
           style varC fill:yellow, stroke:#333,stroke-width:4px;
           style varD fill:lightgreen, stroke:#333,stroke-width:4px;')



