# PartyQueue Terraform Installation

Diese Anleitung beschreibt alle Schritte, damit eine dritte Person das Projekt mit AWS und Terraform ausführen kann.

## 1) Voraussetzungen

- Betriebssystem: macOS, Linux oder Windows (WSL empfohlen)
- Installiert:
  - `git`
  - `aws` (AWS CLI v2)
  - `terraform` (>= `1.5.0`)
- AWS Account mit Berechtigungen für:
  - VPC, Subnet, Route Tables, Security Groups
  - ALB (Elastic Load Balancing)
  - ECS/Fargate, IAM, CloudWatch Logs
  - CloudFront

Versionen prüfen:

```bash
aws --version
terraform version
```

## 2) Repository klonen

```bash
git clone https://github.com/JulianMair/cloudComputing.git
cd cloudComputing/terraform_partyqueue
```

## 3) AWS CLI mit deinem Account verbinden

### Option A (empfohlen): Profil mit `aws configure`

```bash
aws configure --profile partyqueue
```

Setze dabei:

- `AWS Access Key ID`
- `AWS Secret Access Key`
- `Default region name` (z. B. `eu-central-1`)
- `Default output format` (z. B. `json`)

Dann dieses Profil für Terraform verwenden:

```bash
export AWS_PROFILE=partyqueue
```

### Option B: Umgebungsvariablen

```bash
export AWS_ACCESS_KEY_ID="<DEIN_KEY>"
export AWS_SECRET_ACCESS_KEY="<DEIN_SECRET>"
export AWS_DEFAULT_REGION="eu-central-1"
```

### Verbindung testen

```bash
aws sts get-caller-identity
```

Wenn hier eine JSON-Antwort mit Account/Arn kommt, ist AWS CLI korrekt verbunden.


## 4) Terraform initialisieren

Im Projektordner ausführen:

```bash
terraform init
```

Optional prüfen/formatieren:

```bash
terraform fmt
terraform validate
```

## 5) Infrastruktur planen und erstellen

Plan erzeugen:

```bash
terraform plan -out=tfplan
```

Plan anwenden:

```bash
terraform apply tfplan
```

Alternativ direkt ohne Plan-Datei:

```bash
terraform apply
```

## 6) Ausgaben abrufen

Wichtige Outputs:

```bash
terraform output
terraform output cloudfront_domain
terraform output alb_dns
```

Für externe Clients sollte die CloudFront-Domain genutzt werden (`cloudfront_domain`).

## 7) Änderungen durchführen

Nach jeder Änderung an `.tf`:

```bash
terraform plan
terraform apply
```

## 8) Infrastruktur löschen (Cleanup)

Wenn alles entfernt werden soll:

```bash
terraform destroy
```

## 9) Häufige Fehler

- **`No valid credential sources found`**
  - AWS CLI nicht korrekt konfiguriert oder `AWS_PROFILE` nicht gesetzt.
- **`ExpiredToken`**
  - Session abgelaufen, Credentials erneuern.
- **Provider/Plugin Fehler**
  - `terraform init -upgrade` ausführen.
- **Ressourcen schon vorhanden**
  - Gleiche Namen/Konfiguration bereits im Account vorhanden; Namen/Variablen anpassen.

## 10) Sicherheits-Hinweise

- Access Keys niemals ins Repository committen.
- Nach Tests mit `terraform destroy` aufräumen, um Kosten zu vermeiden.
