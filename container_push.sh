# Create ECR (if not already existing)
aws ecr create-repository --repository-name "python-example" --image-scanning-configuration scanOnPush=true

ACCOUNT_ID=$(aws sts get-caller-identity |  jq -r '.Account')
$(aws ecr get-login --no-include-email --region us-east-1)

docker build -t python-example .
docker tag python-example:latest $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/python-example:latest
docker push $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/python-example:latest

cat <<EOT > sample-config.json       
{
    "region": "us-east-1",
    "registry": "${ACCOUNT_ID}",
    "repository": "python-example"
}
EOT