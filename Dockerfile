# Stdio bridge to the hosted server, for directories and clients that run MCP servers locally.
# docker run -i -e UKCD_API_KEY=ukcd_... uk-company-data-mcp
FROM node:22-alpine
RUN npm install -g mcp-remote@0.15.1
ENV UKCD_API_KEY=""
ENTRYPOINT ["sh", "-c", "exec mcp-remote https://data.globalmindsetmarketing.co.uk/mcp ${UKCD_API_KEY:+--header \"Authorization: Bearer $UKCD_API_KEY\"}"]
