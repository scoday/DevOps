## Cloud Migration: Risk Assessment

### Potential Risks (After Migration?)
    - Instance Sizing 
      (e.g.) Were the instances sized properly, are they performing as expected?

    - Office Connectivity to Cloud
      (e.g.) Of course during the migration we would have likely connected a P2P Network 
      but for the purpose of "office work" do we need a network from "CorpyCorp HQ" to Ass-ure?
      
      Diagram 1.0
        [CORPY-CORP-HQ] --> (p2p vpn) --> {CLOUD}

    - User Account Access
      (e.g.) Do users at CorpyCorp need accounts in the cloud as part of their jobs, are the accounts active?

    - File Level Access
      (e.g.) As with above do users have any required access, are they able to do their work?


### Establish CLOUD KPIs (Post Migration)

    - User Experience
        - Page load time
        - Lag
        - Response time
        - Session Duration

    - Application / Component Performnance
        - Error Rates
        - Throughput
        - Availability
	- Apdex

    - Infrastructure
        - CPU Usage (%)
        - Disk Performance
        - Memory Usage
        - Network Throughput

    - Business Engagement
        - Cart adds
        - Conversions and Conversion (%)
        - Engagement Rates

### Establish Perfomance Baselines

Baselining is the process of measuring the current (pre-migration) performance of the app or service in order to determine
if its future (post-migration) performance is acceptable. Baselines help you determine when your migration is complete and
provide validation of post-migration performance improvements expected. Can refer to baselines during a cloud migration to
diagnose any problems that arise.

Set a baseline metric for each KPI.. 
    
### Summary
More to follow - this is a very large topic. 
