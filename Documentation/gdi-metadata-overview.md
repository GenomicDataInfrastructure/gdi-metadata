<!--
SPDX-FileCopyrightText: 2024 Health-RI.

SPDX-License-Identifier: CC-BY-4.0
-->

# GDI Metadata Model Overview

## Class Relationships

```mermaid
graph TD
    Resource["<b>Resource</b><br/><i>dcat:Resource</i>"]

    Catalog["<b>Catalog</b><br/><i>dcat:Catalog</i><br/>title, description,<br/>applicableLegislation"]
    Dataset["<b>Dataset</b><br/><i>dcat:Dataset</i><br/>title, description, identifier,<br/>creator, publisher,<br/>accessRights, applicableLegislation,<br/>status, theme, keyword,<br/>healthCategory, type,<br/>conformsTo, legalBasis,<br/>numberOfRecords,<br/>numberOfUniqueIndividuals,<br/>isReferencedBy"]
    DataService["<b>DataService</b><br/><i>dcat:DataService</i><br/>title, endpointURL"]

    Distribution["<b>Distribution</b><br/><i>dcat:Distribution</i><br/>title, accessURL,<br/>applicableLegislation,<br/>status"]

    AgentCreator["<b>Agent (Creator)</b><br/><i>foaf:Agent</i><br/>name"]
    AgentPublisher["<b>Agent (Publisher)</b><br/><i>foaf:Agent</i><br/>name"]
    AgentHDAB["<b>Agent (HDAB)</b><br/><i>foaf:Agent</i><br/>name"]
    Kind["<b>Kind (Contact Point)</b><br/><i>vcard:Kind</i><br/>fn, hasEmail, hasURL"]
    Identifier["<b>Identifier</b><br/><i>adms:Identifier</i><br/>notation, schemaAgency, name"]

    Resource -->|"extends"| Catalog
    Resource -->|"extends"| Dataset
    Resource -->|"extends"| DataService

    Catalog -->|"dcat:dataset<br/>0..*"| Dataset
    Dataset -->|"dcat:distribution<br/>1..*"| Distribution
    Dataset -->|"dct:creator<br/>1..*"| AgentCreator
    Dataset -->|"dct:publisher<br/>1..1"| AgentPublisher
    Dataset -->|"healthdcatap:hdab<br/>0..1"| AgentHDAB
    Dataset -->|"adms:identifier<br/>0..*"| Identifier

    Distribution -->|"dcat:accessService<br/>0..*"| DataService
    DataService -->|"dcat:servesDataset<br/>0..*"| Dataset

    AgentPublisher -->|"dcat:contactPoint<br/>1..*"| Kind
    AgentHDAB -->|"dcat:contactPoint<br/>1..*"| Kind

    style Resource fill:#e0e0e0,stroke:#666,color:#000
    style Catalog fill:#bbdefb,stroke:#1565c0,color:#000
    style Dataset fill:#c8e6c9,stroke:#2e7d32,color:#000
    style Distribution fill:#fff9c4,stroke:#f9a825,color:#000
    style DataService fill:#ffe0b2,stroke:#e65100,color:#000
    style AgentCreator fill:#e1bee7,stroke:#7b1fa2,color:#000
    style AgentPublisher fill:#e1bee7,stroke:#7b1fa2,color:#000
    style AgentHDAB fill:#e1bee7,stroke:#7b1fa2,color:#000
    style Kind fill:#f8bbd0,stroke:#c2185b,color:#000
    style Identifier fill:#d7ccc8,stroke:#5d4037,color:#000
```

## Namespaces

### Core Data Cataloguing

| Prefix | Full URI | Description |
|---|---|---|
| **dcat** | `http://www.w3.org/ns/dcat#` | **Data Catalog Vocabulary** — W3C standard for describing datasets, distributions, data services, and catalogues. The backbone of the model (including `keyword`). |
| **dct** | `http://purl.org/dc/terms/` | **Dublin Core Terms** — widely-used vocabulary for generic metadata properties like `title`, `description`, `identifier`, `creator`, `publisher`, `type`, `accessRights`, `conformsTo`. |
| **dcatap** | `http://data.europa.eu/r5r/` | **DCAT Application Profile for data portals in Europe** — EU-specific extensions to DCAT, e.g. `applicableLegislation`. |

### Health-Specific

| Prefix | Full URI | Description |
|---|---|---|
| **healthdcatap** | `http://healthdataportal.eu/ns/health#` | **HealthDCAT-AP** — health-sector extension of DCAT-AP, adding properties like `hdab` (Health Data Access Body), `healthCategory`, `numberOfRecords`, `numberOfUniqueIndividuals`. |

### Agents and Contacts

| Prefix | Full URI | Description |
|---|---|---|
| **foaf** | `http://xmlns.com/foaf/0.1/` | **Friend of a Friend** — vocabulary for describing people and organisations. Used for `foaf:Agent` (creator, HDAB) and `foaf:name`. |
| **vcard** | `http://www.w3.org/2006/vcard/ns#` | **vCard ontology** — models contact information (email, name, URL). Used for `vcard:Kind` contact points on the HDAB agent. |

### Identifiers and Asset Description

| Prefix | Full URI | Description |
|---|---|---|
| **adms** | `http://www.w3.org/ns/adms#` | **Asset Description Metadata Schema** — EU vocabulary for describing reusable assets. Used for `adms:Identifier` (secondary identifiers), `adms:schemaAgency`, and `adms:status` on dataset and distribution records. |
| **skos** | `http://www.w3.org/2004/02/skos/core#` | **Simple Knowledge Organization System** — for controlled vocabularies and concept schemes. Used for `skos:Concept` (health categories, themes) and `skos:notation` (identifier strings). |

### Legal and Privacy

| Prefix | Full URI | Description |
|---|---|---|
| **dpv** | `https://w3id.org/dpv#` | **Data Privacy Vocabulary** — W3C vocabulary for describing personal data processing. Used for `dpv:hasLegalBasis` (e.g. consent). |
| **eli** | `http://data.europa.eu/eli/ontology#` | **European Legislation Identifier** — for referencing EU legislation. The EHDS regulation ELI is used as the default `applicableLegislation` value. |

### Shapes and Validation

| Prefix | Full URI | Description |
|---|---|---|
| **sh** | `http://www.w3.org/ns/shacl#` | **Shapes Constraint Language** — W3C standard for validating RDF graphs. All the `.ttl` files define `sh:NodeShape` constraints (min/max counts, patterns, allowed values, etc.). |
| **dash** | `http://datashapes.org/dash#` | **DASH Data Shapes** — extensions to SHACL providing UI hints like `dash:EnumSelectEditor`, `dash:TextFieldEditor`, `dash:URIViewer`. These tell the FDP how to render form fields. |

### Foundational RDF/OWL

| Prefix | Full URI | Description |
|---|---|---|
| **rdf** | `http://www.w3.org/1999/02/22-rdf-syntax-ns#` | Core RDF syntax (lists, types). |
| **rdfs** | `http://www.w3.org/2000/01/rdf-schema#` | RDF Schema — `label`, `comment`, `Literal`, `Resource`. |
| **owl** | `http://www.w3.org/2002/07/owl#` | Web Ontology Language — used to declare ontology metadata and versioning. |
| **xsd** | `http://www.w3.org/2001/XMLSchema#` | XML Schema datatypes — `xsd:string`, `xsd:nonNegativeInteger`, `xsd:dateTime`. |

### Project-Specific

| Prefix | Full URI | Description |
|---|---|---|
| **gdi** | `http://data.gdi.eu/core/p2/` | **GDI's own namespace** — for shapes (`DatasetShape`, `CatalogShape`, etc.) and project-specific concepts/properties like `gdi:1MGCompliant` and `gdi:HealthCategoryHumanGenomic`. |
