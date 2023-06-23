#Conceptual Model

library(decisionSupport)
library(DiagrammeR)


DiagrammeR('graph LR
           B(Overall benefits thought on one hectare)-->A(Result for set spatial variation)
           C((Benefits Agrivoltaics))-->B
           D((Benefits Agroforestry))-->B
           I(Annual cost)-->C
           I1(Maintence cost)-->I
           I2(Insurance)-->I
           N(Investment cost)-->C
           N1(Photovoltaic modules)-->N
           N2(Substructure)-->N
           N3(Grid feed)-->N
           N4(Inverter)-->N
           N5(Installation)-->N
           N6(Mounting)-->N
           M(Profit margin)-->C
           M1(EEG price for full power supply)-->M
           M2(Solar radiation)-->M
           
           F(Investment cost)-->D
           F1(Transplants)-->F
           F2(Hired labour)-->F
           F3(Advice and planning)-->F
           J(Annual costs for the first three years)-->D
           J1(Irrigation)-->J
           J2(Weeding)-->J
           K(Profit margin)-->D
           K1(Subsidies through the GAP)-->K
           K2(Wood yield)-->K
           K3(Wood price)-->K
           O(Price fluctation)-->K2
           O(Price fluctation)-->K3
           
           Q1(Ten percentage area loss)-->B
           Q2(Area yield of the conventional crop)-->B
           
           varB(Costs)
           varC(Risks)
           varD(Profits)
           varQ(Depending on the initial situation)
           
           style A  fill:lightgrey, stroke:#333,stroke-width:6px;
           style B  fill:lightgrey, stroke:#333,stroke-width:4px;
           style C  fill:lightgrey, stroke:#333,stroke-width:4px;
           style D  fill:lightgrey, stroke:#333,stroke-width:4px;
           style I  fill:lightcoral, stroke:#333,stroke-width:2px;
           style I1 fill:lightcoral, stroke:#333,stroke-width:2px;
           style I2  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N1  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N2  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N3  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N4  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N5  fill:lightcoral, stroke:#333,stroke-width:2px;
           style N6 fill:lightcoral, stroke:#333,stroke-width:2px;
           style M2 fill:yellow, stroke:#333,stroke-width:2px;
    
           style J  fill:lightcoral, stroke:#333,stroke-width:2px;
           style J1  fill:lightcoral, stroke:#333,stroke-width:2px;
           style J2  fill:lightcoral, stroke:#333,stroke-width:2px;
           style F  fill:lightcoral, stroke:#333,stroke-width:2px;
           style F1  fill:lightcoral, stroke:#333,stroke-width:2px;
           style F2  fill:lightcoral, stroke:#333,stroke-width:2px;
           style F3  fill:lightcoral, stroke:#333,stroke-width:2px;
           style K1  fill:lightgreen, stroke:#333,stroke-width:2px;
           style K2 fill:lightgreen, stroke:#333,stroke-width:2px;
           style K3 fill:lightgreen, stroke:#333,stroke-width:2px;
           style O fill:yellow, stroke:#333,stroke-width:2px;
           style Q1 fill:lightblue, stroke:#333,stroke-width:2px;
           style Q2 fill:lightblue, stroke:#333,stroke-width:2px;
          
           style varB fill:lightcoral, stroke:#333,stroke-width:4px;
           style varC fill:yellow, stroke:#333,stroke-width:4px;
           style varD fill:lightgreen, stroke:#333,stroke-width:4px;
           style varQ fill:lightblue, stroke:#333,stroke-width:4p')
           



