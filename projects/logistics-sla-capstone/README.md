# Logistics SLA Capstone

**Goal:** Analyze delivery performance against service-level agreements, building on YuvaIntern logistics experience.

## Status

- [ ] SLA definitions and KPI list confirmed
- [ ] Shipment-level dataset prepared
- [ ] SLA breach analysis
- [ ] Root-cause / segment analysis
- [ ] Dashboard and final write-up

## Structure

- `data/` — shipment and SLA reference data
- `notebooks/` — analysis
- `src/` — reusable transformations
- `outputs/` — charts and exports

## Candidate KPIs

| KPI | Definition |
| --- | --- |
| On-time delivery rate | % of shipments delivered by the committed date |
| SLA breach count | Shipments delivered after the committed date |
| Average delay | Mean days late for breached shipments |
| Carrier performance | On-time rate by carrier / lane |
| Exception rate | % of shipments with a reported exception |

> Replace the sample KPI table with the exact SLAs from your YuvaIntern project before publishing.
