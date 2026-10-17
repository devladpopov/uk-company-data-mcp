# UK Company Data MCP server

Remote [Model Context Protocol](https://modelcontextprotocol.io) server with data on every UK company from Companies House: the register of 5.6 million companies plus balance sheet and profit and loss figures from about 35 million machine-readable (iXBRL) accounts filed since 2008, updated daily.

Ask Claude, ChatGPT, Cursor or any MCP client things like "check TESCO PLC", "compare these two suppliers", "find London software companies with falling cash" or "alert me if this customer files late".

- Endpoint: `https://data.globalmindsetmarketing.co.uk/mcp` (Streamable HTTP)
- Auth: `Authorization: Bearer ukcd_...` (or `?key=ukcd_...` for clients that cannot send headers)
- Free key, 50 requests a month, no card: https://data.globalmindsetmarketing.co.uk/docs
- REST mirror and OpenAPI spec: https://data.globalmindsetmarketing.co.uk/openapi.json

## Tools

| Tool | What it does |
|---|---|
| `lookup_company` | Register details and financial history for a company number: status, SIC codes, filing deadlines, charges, net assets, cash, creditors, turnover and profit where filed |
| `search_by_name` | Search all 5.6M companies by name, exact matches and active companies first |
| `search_companies` | Filter companies by risk band, trajectory, size class, total assets, employees, negative net assets and insolvency signals |
| `compare_companies` | Two companies side by side |
| `market_stats` | Aggregate statistics across the register |
| `find_triggers` | Companies matching a trigger (rapid growth, cash rich, distressed, new investment, deteriorating, improving) for B2B lead generation |
| `recent_changes` | Latest accounts published to Companies House |
| `watch_add`, `watch_remove`, `watch_list`, `get_alerts` | Watchlist monitoring: status changes, overdue filings, new accounts, new charges, negative net assets, 30%+ falls in net assets or cash |

## Connect

Claude Code:

```bash
claude mcp add --transport http uk-company-data https://data.globalmindsetmarketing.co.uk/mcp --header "Authorization: Bearer ukcd_YOUR_KEY"
```

Claude Desktop, Cursor, Windsurf and other clients (`mcp.json` / `claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "uk-company-data": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://data.globalmindsetmarketing.co.uk/mcp", "--header", "Authorization: Bearer ${UKCD_API_KEY}"],
      "env": { "UKCD_API_KEY": "ukcd_YOUR_KEY" }
    }
  }
}
```

claude.ai custom connector: add `https://data.globalmindsetmarketing.co.uk/mcp?key=ukcd_YOUR_KEY`.

Get a key:

```bash
curl -X POST https://data.globalmindsetmarketing.co.uk/v1/keys/free -H "Content-Type: application/json" -d '{"email":"you@example.com"}'
```

## Plans

Free: 50 requests a month, 5 watched companies. API Pro: GBP 39 a month, 5,000 requests a month and 50 watched companies. Details: https://data.globalmindsetmarketing.co.uk/pricing

## Data and licence

Source: Companies House Free Company Data Product and accounts bulk data, used under the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/). Figures are as filed, not estimated or adjusted. Not a credit rating. Methodology: https://data.globalmindsetmarketing.co.uk/about/methodology

This repository (docs and config) is MIT licensed. The server is hosted and operated by Global Mindset Marketing Ltd (company 15738438, Manchester, UK). Contact: info@globalmindsetmarketing.co.uk
