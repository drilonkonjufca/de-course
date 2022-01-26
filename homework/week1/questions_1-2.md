


# project credentials
* `project name:   de-course`
* `projectid:      tribal-bird-339019`
* `gcp key: ~/.ssh/gcloud/de_course/tribal-bird-339019-922b2fc81066.json`

# other tasks
* `Enable API: Identity and Access Management (IAM) API`

# commands
```bash
# initialize and authenticate
export GOOGLE_APPLICATION_CREDENTIALS=~/.ssh/gcloud/de_course/tribal-bird-339019-922b2fc81066.json
gcloud init
gcloud auth -default login
```


```bash
# Question 1. Google Cloud SDK
gcloud --version

Google Cloud SDK 369.0.0
alpha 2022.01.14
beta 2022.01.14
bq 2.0.72
core 2022.01.14
gsutil 5.6
```



```bash
# Question 2. Terraform
terraform init
terraform plan
terraform apply

# RESULT:
# -----------------------------------------------------------------------------
var.project
  Your GCP Project ID

  Enter a value: tribal-bird-339019


Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "trips_data_all"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "europe-west6"
      + project                    = "tribal-bird-339019"
      + self_link                  = (known after apply)

      + access {
          + domain         = (known after apply)
          + group_by_email = (known after apply)
          + role           = (known after apply)
          + special_group  = (known after apply)
          + user_by_email  = (known after apply)

          + view {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + table_id   = (known after apply)
            }
        }
    }

  # google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "EUROPE-WEST6"
      + name                        = "dtc_data_lake_tribal-bird-339019"
      + project                     = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }

          + condition {
              + age                   = 30
              + matches_storage_class = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_bigquery_dataset.dataset: Creation complete after 2s [id=projects/tribal-bird-339019/datasets/trips_data_all]
google_storage_bucket.data-lake-bucket: Creation complete after 2s [id=dtc_data_lake_tribal-bird-339019]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```


