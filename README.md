# Lesson 8–9: Jenkins + Terraform + Helm + Argo CD (GitOps CI/CD)

## Project Overview

This project presents the implementation of a comprehensive CI/CD pipeline based on Terraform, Jenkins, Helm, Argo CD, and AWS services, specifically Amazon EKS and Amazon ECR.

The primary objective of this work is to illustrate a contemporary GitOps-oriented software delivery model. Within this approach, infrastructure resources are provisioned declaratively through Terraform, Continuous Integration processes are executed by Jenkins, Continuous Deployment is managed by Argo CD, and application delivery is fully automated through version-controlled changes maintained in Git repositories.

## Architecture Overview

Infrastructure:

- Terraform remote state management implemented with Amazon S3 and DynamoDB
- Virtual Private Cloud (VPC) architecture incorporating public and private subnets, together with a NAT Gateway
- Amazon EKS cluster configured with a managed node group
- Amazon ECR repository designated for Docker image storage

CI/CD:

- Jenkins deployed on the EKS cluster by means of Helm
- Jenkins pipeline responsible for building Docker images, pushing them to Amazon ECR, and updating Helm chart values in the Git repository
- Argo CD deployed on the EKS cluster using Helm
- Argo CD Application configured to automatically monitor and synchronise repository changes with the Kubernetes cluster in accordance with GitOps principles

## Repository Structure

Infrastructure repository:
lesson-8-9-infra/

- backend.tf
- providers.tf
- k8s_providers.tf
- main.tf
- variables.tf
- outputs.tf
- modules/
  - s3-backend
  - vpc
  - ecr
  - eks
  - jenkins
  - argo_cd
- README.md

Helm charts repository:
lesson-8-9-charts/

- charts/
  - django-app

## How to Apply Terraform

Prerequisites:

- AWS CLI configured using `aws configure`
- Terraform version 1.5 or later
- AWS account with appropriate permissions for infrastructure provisioning

Steps:

1. Navigate to the infrastructure repository:
   `cd lesson-8-9-infra`
2. Initialise Terraform:
   `terraform init`
3. Apply the infrastructure definition:
   `terraform apply`

The execution of Terraform provisions the required AWS resources, installs Jenkins and Argo CD via Helm, and creates an Argo CD Application to enable GitOps-based deployment workflows.

## How to Test the Jenkins Job

1. After the successful execution of `terraform apply`, Jenkins is made accessible through a Kubernetes LoadBalancer service.
2. Retrieve the Jenkins administrator password:
   `terraform output jenkins_admin_password`
3. Authenticate in the Jenkins web interface.
4. Execute the pipeline, which performs the following operations:
   - builds the Docker image,
   - pushes the generated image to Amazon ECR,
   - updates the image tag in the Helm chart stored in the Git repository.

## How to View the Result in Argo CD

1. Argo CD is exposed through a Kubernetes LoadBalancer service.
2. Retrieve the initial Argo CD administrator password:
   `terraform output argocd_initial_admin_password`
3. Authenticate in the Argo CD web interface.
4. Inspect the `django-app` Application, which continuously tracks the Helm chart repository.
5. Once Jenkins updates the Helm values in Git, Argo CD automatically detects the modification, synchronises the desired state, and deploys the updated application version to the cluster.

## Known Limitations

During local testing, connectivity to the Kubernetes API through `kubectl`, as well as through Terraform Kubernetes and Helm providers, may fail due to local DNS resolution issues affecting `*.eks.amazonaws.com`. This behaviour is dependent on the specific router or local network configuration.

Despite this limitation, the infrastructure itself is provisioned successfully:

- the EKS cluster reaches `ACTIVE` status,
- the managed node group reaches `ACTIVE` status,
- Jenkins and Argo CD are correctly defined, provisioned, and installed through Terraform and Helm.

In production environments, CI pipelines, or when public DNS resolvers such as `1.1.1.1` are utilised, the solution functions as intended.

## Cleanup

To prevent unnecessary cloud expenditure, all resources can be removed by executing:
`terraform destroy`

This operation also deletes the S3 bucket and DynamoDB table that were used to maintain Terraform state data.

## Summary

This project demonstrates the practical integration of Infrastructure as Code through Terraform, Continuous Integration through Jenkins, Continuous Deployment through Argo CD, and a GitOps-based deployment strategy on AWS EKS. As such, it reflects a modern DevOps delivery paradigm that supports efficient, reliable, and predictable software release processes.
