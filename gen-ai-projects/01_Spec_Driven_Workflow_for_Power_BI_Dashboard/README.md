flowchart LR

subgraph Client[Client / Business Owner]
    A1[Explains business need]
    A2[Confirms scope and KPIs]
    A3[Validates final requirements]
end

subgraph Analyst[BI Analyst / Consultant]
    B1[Conducts discovery meeting]
    B2[Reviews AI-generated summary]
    B3[Defines business objective]
    B4[Validates KPI logic]
    B5[Approves pre-build package]
end

subgraph AI[AI Assistant]
    C1[Structures raw notes]
    C2[Creates business brief]
    C3[Drafts requirements spec]
    C4[Drafts functional spec]
    C5[Drafts KPI dictionary]
    C6[Creates validation checklist]
end

subgraph Delivery[Power BI Delivery]
    D1[Dashboard structure]
    D2[Visual design spec]
    D3[Technical Power BI spec]
    D4[Build backlog]
    D5[Power BI build phase]
end

A1 --> B1
B1 --> C1
C1 --> B2
B2 --> C2
C2 --> B3
B3 --> C3
C3 --> A2
A2 --> C4
C4 --> C5
C5 --> B4
B4 --> D1
D1 --> D2
D1 --> D3
D2 --> D4
D3 --> D4
D4 --> C6
C6 --> B5
B5 --> A3
A3 --> D5
