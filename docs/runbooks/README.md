# Operational Runbooks

## What are Runbooks?

Runbooks are step-by-step guides for handling operational tasks and incidents. They ensure that:
- Any engineer can respond to an incident (not just the person who built it)
- Responses are consistent and tested
- Knowledge isn't locked in one person's head
- On-call engineers can resolve issues at 3 AM without thinking

## Runbook Index

| Runbook | Description | Last Updated |
|---------|-------------|--------------|
| (Coming soon) | Database failover | - |
| (Coming soon) | API high latency | - |
| (Coming soon) | Certificate renewal | - |
| (Coming soon) | Scaling procedures | - |

## Runbook Template

```markdown
# Runbook: [Title]

## Summary
[One-line description of what this runbook addresses]

## Symptoms
[How do you know this is happening? What alerts fire?]

## Impact
[What is affected? Users? Internal services?]

## Steps to Resolve
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Verification
[How do you confirm the issue is resolved?]

## Escalation
[Who to contact if this doesn't work?]

## Post-Incident
[What to do after resolution — postmortem, follow-up tasks]
```
