---
title: "mlrd.tech Privacy Policy"
layout: legal
---
# `mlrd` Privacy Policy

*Effective Date: January 19, 2026*

This Privacy Policy describes the privacy practices of 17468296 Canada, Inc., a corporation registered under the laws of Canada, doing business as mlrd.tech ("mlrd.tech," "we," "us," or "our") and how we collect, use, and disclose information in connection with our software product (mlrd), websites, and APIs (collectively, the "Services"). We treat all personal information covered by this Privacy Policy as pertaining to individuals acting as business representatives, and not in their individual or household capacity.

By using our Services, you acknowledge that you have read and understood this Privacy Policy. This Privacy Policy is incorporated into and forms part of our Terms of Service.

# **1\. About mlrd**

mlrd is a DynamoDB-compatible API that runs and processes data locally on your servers. It is *not* a SaaS or hosted product; it is a binary program that you download and run within your environment. Use is granted by license on a per-table basis.

To validate licenses on startup, mlrd must communicate with our APIs. (HTTPS/TLS is always enforced.) This may transmit your table names unless you define a table alias, as described in Section 2\.

App data (such as database items, rows, or records) that `mlrd` receives from your applications or database servers is **NOT** collected, transmitted, or shared with mlrd.tech. Therefore, this Privacy Policy does not address or pertain to app data because `w`e do not have access to your app data.

# **2\. Information We Collect**

## **2.1 License Verification Data**

On startup, mlrd must contact our API (currently, `https://api.mlrd.app`) to verify the validity of your licenses. During this verification process, the following information is transmitted:

* **API Key:** A unique identifier assigned to your account.  
* **Table License Allocation ID (“Alloc ID”)**: The alloc ID identifies the license to which the table is being applied.  
* **mlrd Version**: The version of the program being run.  
* **Table Reference**: The table alias if you define one, else the real table name, in that order. If you wish to keep your real table names private, be sure to define a table alias in each table config file.

This license verification data is necessary to provide the Services and enforce our licensing terms. Except for table references, we already know your API key, alloc IDs, and mlrd version because we generated them for you.

## **2.2 Anonymized Usage Statistics (“Stats”)**

mlrd may collect and send Stats to our API (currently, `https://stats.mlrd.app`)) to help us improve our products and services.

* **Free Trial License:** If you elect to use a free trial license, Stats are mandatory as a condition of the free trial Terms of Service. This means mlrd might stop running (exit) if it cannot successfully send Stats.  
* **Paid License Users:** If you use a paid license, Stats are explicitly and only opt-in, which you can enable (opt in) or disable (opt out) any time through the customer portal (https://mlrd.app).

For transparency, mlrd.tech makes its Stats client and API source code available at [https://github.com/mlrd-tech/stats](https://github.com/mlrd-tech/stats). This source code contains all Stats data collected and stored, and data may be added or removed to Stats without updating this Privacy Policy provided that Stats remain anonymous.

Anonymization happens on the client side, by mlrd, before being sent to our API.

Sending Stats requires a valid API key, which identifies a customer, but we do not store API keys with Stats. Otherwise, stats are anonymized and do not contain personally identifiable information or actual customer data. Once stored, Stats are completely anonymous.

## **2.3 Customer Portal and Website**

When you create an account at [https://mlrd.app](https://mlrd.app) or otherwise interact with our website and customer portal, we collect:

* Information you voluntarily provide, which may include your name, email address, company name, and other contact information.  
* Web analytics: clicks, web browser brand, device type, location by country, referrer  
* System access logs: IP address and all data in the HTTP request

## **2.4 Billing and Payment Information**

Billing information, such as billing periods and dollar amounts, is stored by us in order to charge applicable license fees. Our billing information does *not* include your payment information.

All payment information is processed by our third-party payment processor. mlrd.tech does not collect, store, or have access to your credit card number or other payment details. Please refer to our payment processor's privacy policy for information on how they handle your payment data: [https://polar.sh/legal/privacy](https://polar.sh/legal/privacy)

## **2.5 API Access**

When you or an instance of mlrd running locally on your servers contacts one of our APIs, we log the IP address and all data in the HTTP request, with the exception of Stats.

**Stats**:

* Successfully received and stored Stats log only the generic action so that we can monitor the ingestion rate of the API.  
* Unsuccessful Stats log the IP address and all data in the HTTP request so that we can prevent abuse.

## **2.6 Audit Log**

Across all of our Services, for all accounts we record a unified audit log of every change and certain (read-only) accesses. Audit log events include:

* Timestamp (when the event occurred)  
* User ID who made the change or access  
* Org ID the user was acting within (if any)  
* The type of change or access  
* Metadata about the change or access

Your audit log is available in the customer portal. 

# **3\. How We Use Your Information**

We use the information we collect for the following purposes:

| Information&nbsp;Collected | Purpose and Usage |
| ---- | ---- |
| License&nbsp;Verification&nbsp;Data&nbsp;&nbsp; | Verify that licenses are valid and mlrd is allowed to run. Strictly necessary because licenses are renewed monthly, and without a robust license verification process, it’s possible to use mlrd without limitations, which would make doing business and providing the Services infeasible. |
| Stats | Improve mlrd and the Services for customers. Since mlrd is distributed binary, not a SaaS or hosted product, Stats are important to help us provide the most value to customers by seeing (anonymously) how mlrd is and isn’t used. We analyze Stats to answer questions like “Are workloads read-heavy, write-heavy, or mixed?”, and “Is mlrd memory consumption reasonable and stable?” |
| Customer Portal and Websites | Provide, maintain, and improve our Services. Standard information and usage necessary for websites and customer portals, also to communicate with you regarding your account, license, and support. For example, our customer portal uses cookies to store authenticated session data. User credentials and authentication is handled by a third-party authentication service. Other than your email address, which is not secret or sensitive data, mlrd.tech never stores or processes your credentials. Even if authentication appears to originate from one of our domains (i.e. branded), behind the scenes it’s securely processed by a third party. We use web analytics to track website usage, referrals, demographics, conversions, and click-through rates. We use this data to answer questions like “Are we providing a product that people want to buy?”, and “Are they actually buying it?” |
| Billing and Payment Information | Securely pass on to our merchant of record (“MoR”). mlrd.tech stores billing information, but we never store or process your payment information. This is not our business, so we pay an MoR to handle this. When you provide us payment information, we securely pass it to the MoR. Even if payment appears to originate from one of our domains (i.e. branded), behind the scenes payment information is always and only handled by our MoR. |
| API Access | Analyze access to our systems for security and abuse prevention. We use this data to answer questions like “Is a bad actor attempting to DoS the API?”, and “Is there suspicious activity from places where we have no customers?” |
| Audit Log | Provide customers with an audit log for their account, and to analyze customer engagement. For the customer, the audit log is a standard security and compliance feature. For us, we use audit logs to answer questions like “How many customers upgrade from a free trial license to a paid license?”, and “Which accounts are inactive, likely abandoned?” |

# **4\. How We Share Your Information**

**We do not sell, rent, or trade your personal information to third parties for marketing purposes.** We do not use your data for artificial intelligence (AI) or machine learning (ML) training purposes.

We may share your information in the following limited circumstances:

* **Service Providers:** We may share information with trusted third-party service providers who assist us in operating our Services, such as payment processors and authentication services, subject to confidentiality obligations.  
* **Legal Compliance:** We may disclose information if required by law, regulation, legal process, or governmental request.  
* **Business Transfers:** In connection with a merger, acquisition, or sale of assets, your information may be transferred as part of that transaction.

# **5\. Data Retention**

We retain all data (except payment information, which we never store) for as long as necessary to provide the Services, comply with our legal obligations, resolve disputes, and enforce our agreements.

**Stats:** Because Stats are anonymized at the point of collection and cannot be linked back to any specific customer once stored, they are retained indefinitely and cannot be deleted on a per-customer basis. There is no technical means to identify which Stats belongs to which customer.

# **6\. Data Security**

We are serious about data security and we encourage you to be, too. The first and best data security practice for both parties is that we do not have access to your app data. mlrd does not collect, transmit, or share app data with mlrd.tech. We strongly encourage you never to share your app data with us. If you must for support, be sure to obfuscate the data first.

With respect to your information, we implement reasonable administrative, technical, and physical safeguards to protect the information we collect, including but not limited to: enforcing HTTPS on all our Services, using specialized third parties for authentication and payment processing, and maintaining an audit log of all changes to your account.

However, no method of transmission over the Internet or electronic storage is completely secure, and we cannot guarantee absolute security.

# **7\. Your Rights and Choices**

Depending on your jurisdiction, you may have certain rights regarding your personal information, including:

• The right to access, correct, or delete your personal information.

• The right to withdraw consent to optional data collection.

• The right to object to certain processing activities.

• The right to lodge a complaint with a supervisory authority.

To exercise any of these rights, please contact us at privacy@mlrd.tech. Note that we cannot delete Stats as explained in Section 5\.

# **8\. International Data Transfers**

Your information may be transferred to and processed in Canada, the United States, or European countries where we or our service providers operate. These countries may have different data protection laws than your country of residence. By using our Services, you consent to such transfers.

# **9\. Children's Privacy**

Our Services are not directed to children under the age of 18\. We do not knowingly collect personal information from children under 18\. If you believe we have collected information from a child under 18, please contact us immediately.

# **10\. Changes to This Privacy Policy**

We may update this Privacy Policy from time to time. If we make material changes, we will notify you by posting the updated policy on our website and updating the "Effective Date" above. Your continued use of the Services after any changes constitutes your acceptance of the revised Privacy Policy.

# **11\. Contact Us**

If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:

**17468296 Canada, Inc. DBA mlrd.tech**

Email: privacy@mlrd.tech

Website: [https://mlrd.tech](https://mlrd.tech)
