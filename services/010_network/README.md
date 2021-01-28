# FEVO Networking Service

### SUMMARY

This project module generates the Fevo networking infrastructure that runs across all environments (app, dev, qa, prod) and eventually multiple cloud providers. Functionality includes:

- 1 VPC
- 4 Subnets (APP, Prod, QA, Dev)
- Network ACL

### REFERENCE DOCUMENTATION

To use this project, you will need to understand your [environments] according to this table:

| AWS Profile | Blue | Green | Region    | tfvars File |
| ---         | ---  | ---   | ---       | ---         |
| fevo-dev    | d211 | d212  | us-east-1 | D211.tfvars |
| fevo-qa     | q231 | q232  | us-east-2 | Q231.tfvars |
| fevo-prod   | p231 | p232  | us-east-2 | P231.tfvars |
| fevo-app    | a231 | a232  | us-east-2 | A231.tfvars |

### PRE-REQUISITE SETUP

You will need to set up your `~/.aws/config` to include the [profiles]for:

- fevo-app
- fevo-dev
- fevo-qa
- fevo-prod

### CREATING NETWORK

1. Set your AWS profile in the terminal to the target network you are creating.
    > `export AWS_PROFILE=[profile_name]`

1. Login to terraform using terraform cloud account from Passpack
    > `terraform login`
    
1. Initialize terraform from infrastructure-network-cluster/services/010_network directory.
    > `terraform init`

1. Select the workspace (eg. P231) or create if it doesn't exist yet
    > `terraform workspace list` <br/>
    > `terraform workspace select [environment]` <br/>
    > OR <br/>
    > `terraform workspace new Q232` where Q232 = [environment]<br />

1. [Optional] If your last step requires a new workspace, set the configuration to local execution mode via Terraform Cloud web interface
    > Log into [Terraform Cloud](https://app.terraform.io/app/fevo-inc/workspaces)<br/>
    > Navigate to fevo-inc > Workspaces > [environment ie, P231]] > Settings > General > confirm Execution Mode = Local

1. Deploy service via terraform apply (for troubleshooting, you can `export TF_LOG=TRACE`)
    > `terraform apply --var-file=[environment].tfvars`

### CONFIGURING THE NETWORK CONNECTIVITY

After a new network is created, it will need connections to the wider network (ie, other VPCs). This is accomplished through a mixture of VPC Peering and Transit Gateway Attachments. Reference Diagram [here](https://drive.google.com/file/d/162BkX_UwW-WE32K8mTTd_suKlMu_GT3n/view?usp=sharing).

1. Turn on Resource Sharing between accounts *Only for a NEW AWS Account – existing account proceed to step 2*<br/>

    - Create a resource share. If the new VPC in an existing connected account, skip this step
	- Check in the new account/region if you see a TRANSIT GATEWAY in the region
	- From the network account, create a resource share
    - Resource Access Manager (make sure you are in the same region as the new VPC)
    - Create Resource Share
    - Resources (choose Transit Gateway from pull down menu)
    - click on the TGW
    - Principals (add the account number of the receiver VPC)
    - Click [create resource share]
    - On the new VPC account, go to Resource Access Manager - Make sure you are in the new VPC region
    - On the left, shared with me, accept

2. Create Transit Gateway Attachments
    - Go the network account (shared services), make sure you are in the same region as the new VPC
    - From the VPC menu click on ' Transit Gateway Attachment'
    - Create Transit Gateway Attachment, from the new vpc account 
        - click on Transit gateway attachment from the left menu
        - Click on create transit gateway attachment, fill the attachment information
        - pick the transit gateway
        - use the remote VPC name as a tag 'for ex. D211'- use the VPC-netman subnets (one per AZ) as the peering subnets.
        - from the network account, go to Transit gateway attachment and accept the request 
        - Change the name to (VPC name - Web subnet)

3. Update routing
    - In the network account, click on Transit Gateway Routing table
    - check TRx-MAIN, click on associations, de-associate (delete association) the new VPC form the main routing table, may take couple of minutes
    - pick the routing table corresponding to the environment (Prod-RT, Dev-RT, QA-RT, etc.), associate the VPC with the correspondent routing table, create association (may take couple of minutes)
    - click on 'Propagation’, Create propagation, pick the new VPC and create propagation
    - Chose the correspondent routing table to the environment (Prod-RT/Dev-RT/QA-RT) and create propagation to the new VPC 
    - click on the route table, confirm the new VPC subnets are shown

4. For legacy VPC routing only
    - Create a propagation from the Legacy-RT to the new VPC 

5. Additional steps on the VPC
    - Make sure you have routes (static routes) on the subnets to specific summary routes out toward the TGW attachment
    - Use summarization, new VPC's have summary routes to 10.0.0.0/8 that covers all legacy subnets
    - Each tier should ONLY have routes to approved summary (web to web/api, DB - DB/API, API tier needs access to all three tiers)
    - Due to address summarization of the 10.x network we need to add static route to the 10.x CIDR of the VPC to the PROD-RT

6. Verification
    - Network Manager should be used s the first step to verify the WAN routing is configured correctly. It can also be used for troubleshooting purpose
    - From the network account, VPC menu, Network Manager, View my Global Network - > click on global-network FV-Net
    - Go to Route Analyzer
    - Fill source and destination information and cluck 'Run route analysis) (pick a random ip address in the one of the subnets in each VPC, does not have to be a live IP)
    - you should see both connected 

### DESTROYING NETWORK

1. Set your AWS profile in the terminal to the target network you are creating.
    > `export AWS_PROFILE=[profile_name]`

1. Login to terraform using terraform cloud account from Passpack
    > `terraform login`

1. Select the workspace (eg. P231)
    > `terraform workspace list` <br/>
    > `terraform workspace select [environment]` <br/>

1. Initialize terraform from infrastructure-network-cluster/services/010_network directory.
    > `terraform init`

1. destroy
    > `terraform destroy --var-file=[environment].tfvars`

### TROUBLESHOOTING

1. Cannot destroy the network
    > Error: Error deleting VPC: DependencyViolation: The vpc 'vpc-0d583caa141c170b6' has dependencies and cannot be deleted. Check if no EKS resources were left behind such as LB's and Security Groups, delete them and run terraform destory again

1. Any IAM errors saying your assumed role does not have permissions
    > Check that you have all AWS configs set up (fevo-dev, fevo-qa, fevo-prod, networking). You can reference the PRE-REQUISITES section above.

### [ADVANCED] AUTHORING ENVIRONMENTS

If you are creating a new environment that does not exist today, please check there isn't a tfvars file yet. The initial build out has 4 environments that span APP,DEV,QA,PROD each with a "blue/green" pair to facilitate infrastructure upgrades and redundancy. 


The expectations for the environment based networks is that there is a stable shared services network that will manage this network. 

- Ensure the VPC Peering details to the Service Account to allow Rancher to communicate with the cluster.
- Ensure the shared-services-1 AWS Account ID at "shared_services_1_acceptor_account_id" inside [environment].tfvars
- Ensure that the shared-services-1 VPC has a "Namespace" tag with a value of "shared-services-1" via the AWS Console.
- Check that the `locals.tf` ensure `locals.vpc.peering.shared_services_1.acceptor_vpc_tags` has a "Namespace" tag with a value of "shared-services-1".