# ECR Container Image Re-Scan

Based entirely on [Michael Hausenblas's implementation](https://github.com/mhausenblas/ecr-continuous-scan)

Just ported some of the functionality to use Serverless instead + removed the need for init buckets

![ECR Continuous Scanner](https://d2908q01vomqb2.cloudfront.net/fe2ef495a1152561572949784c16bf23abb28057/2019/10/18/ecr-continuous-scan-architecture-1024x833.png)

## Serverless Deploy

```bash
serverless deploy
```

## Test

Retrieve the endpoint created for you and export a variable containing it.

```bash
# Serverless: Stack update finished...
# endpoints:
#   POST - https://jn03zi6twg.execute-api.us-east-1.amazonaws.com/dev/configs
#   DELETE - https://jn03zi6twg.execute-api.us-east-1.amazonaws.com/dev/configs/{id}
#   GET - https://jn03zi6twg.execute-api.us-east-1.amazonaws.com/dev/configs
#   GET - https://jn03zi6twg.execute-api.us-east-1.amazonaws.com/dev/summary
#   GET - https://jn03zi6twg.execute-api.us-east-1.amazonaws.com/dev/findings/{id}

export ECRSCANAPI_URL="https://jn03zi6twg.execute-api.us-east-1.amazonaws.com/dev"
```

### Create the demo repo

```bash
./container_push.sh
```

### Add a configuration file

```bash
curl -s --header "Content-Type: application/json" --request POST --data @sample-config.json $ECRSCANAPI_URL/configs/
```

## Issues

You might get rate limited from the ECR Vuln scanner

![ECR Rate limits](rate-limits.png)
