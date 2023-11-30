provider "github" {
  token = "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"
}

variable "nom_du_repo" {
  description = "Nom du dépôt GitHub"
  type        = string
}

resource "github_repository" "mon_repo" {
  name        = var.nom_du_repo
  description = "Créé avec Terraform"
  visibility  = "private"
}