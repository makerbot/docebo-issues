This script reproduces an issue with the production Docebo instance (university.makerbot.com).
The same result occurred when testing with the Docebo URL for this instance (makerbotecs.docebosaas.com).

Strangely enough, it does not occur on the sandbox instance (makerbotsandbox.docebosaas.com).

## Instructions
1. Generate a Docebo Access Token (https://www.docebo.com/knowledge-base/authentication-api-ssp-app-grant-types/)
2. Run `./create-user.sh $DOCEBO_ACCESS_TOKEN`
3. Observe that the first user will not have their additional field populated, but the second will after adding Docebo session to cookie header
