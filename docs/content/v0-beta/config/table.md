---
bookToc: false
---
<h1>Table Config</h1>

<div class="yaml-doc-container">
  <div class="line" data-line-num="1">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">1</span><a name="lkey"><span class="setting">lkey: ""</span></a></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="1" data-end-line="1">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Line 1</span>
          License Key
        </div>
        <div class="doc-content" style="z-index: 99;">
          <div class="doc-text">

Required license key.
`mlrd -license` to print all active licenses, or get licenses at https://mlrd.app.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="2">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">2</span><span class="setting"></span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="3">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">3</span><a name="ddb"><span class="setting">ddb:</span></a></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="3" data-end-line="16">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 3-16</span>
          DynamoDB Table
        </div>
        <div class="doc-content" style="z-index: 98;">
          <div class="doc-text">

`table_name` sets the DynamoDB table name that clients use.
This setting is always required.

The table name must be or match the common table name in the [table envs]({{< ref "table-envs" >}}) for the license.

Values shown are only examples.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="4">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">4</span><span class="setting">&nbsp;&nbsp;table_name: "Albums"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="5">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">5</span><span class="setting">&nbsp;&nbsp;primary_key:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="5" data-end-line="7">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 5-7</span>
          Primary Key
        </div>
        <div class="doc-content" style="z-index: 97;">
          <div class="doc-text">

Primary key definition: required `partition_key` and optional `sort_key`.

Values are coded attributes: "<type>,<attribute>".
For example:
* "S,Artist"
* "N,Year"
* "B,Checksum"

If the primary key is not defined and the table mode is transparent or migration, mlrd auto-defines the table by calling `DescribeTable`.
In SQL table mode, the primary key (and secondary indexes) must be defined.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="6">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">6</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;partition_key: "S,Artist"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="7">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">7</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;sort_key: "S,Title"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="8">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">8</span><span class="setting">&nbsp;&nbsp;indexes:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="8" data-end-line="11">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 8-11</span>
          Secondary Indexes
        </div>
        <div class="doc-content" style="z-index: 96;">
          <div class="doc-text">

Optional map of secondary indexes.
Map key: case-sensitive index name.
Map fields:

```yaml
partition_key: ""
sort_key: ""
include: []
```

For example, an index named "Year":

```yaml
ddb:
  indexes:
    Year:
      partition_key: "N,Year"
      include:
        - Label
```

`include` is a list of attributes to project with the secondary index.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="9">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">9</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;Year:</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="10">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">10</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;partition_key: "N,Year"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="11">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">11</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;include: []</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="12">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">12</span><span class="setting">&nbsp;&nbsp;aws:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="12" data-end-line="16">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 12-16</span>
          AWS
        </div>
        <div class="doc-content" style="z-index: 95;">
          <div class="doc-text">

Configures AWS account access.
No values by default, which uses AWS SDK defaults.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="13">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">13</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;config_files: []</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="14">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">14</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;credentials_files: []</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="15">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">15</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;profile: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="16">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">16</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;region: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="17">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">17</span><span class="setting"></span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="18">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">18</span><a name="migration_step"><span class="setting">migration_step: ""</span></a></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="18" data-end-line="18">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Line 18</span>
          Migration Step
        </div>
        <div class="doc-content" style="z-index: 94;">
          <div class="doc-text">

Sets migration step, runs table in migration mode.
See [migration overview]({{< ref "overview" >}}).
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="19">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">19</span><span class="setting"></span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="20">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">20</span><a name="mysql"><span class="setting">mysql:</span></a></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="20" data-end-line="45">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 20-45</span>
          MySQL
        </div>
        <div class="doc-content" style="z-index: 93;">
          <div class="doc-text">

MySQL connection and credential settings.

If `hostname` and `socket` are not set, mlrd auto-detects a local MySQL socket; if that fails, it defaults to `host: 127.0.0.1:3306`.
For consistency and clarity, set `socket` or `hostname`.
If both are set, `socket` takes precedence.

MySQL password source: one of `password`, `password_file`, `iam_auth`, or `password_secret` must be set and non-empty.
mlrd supports online password rotation: password source is reloaded if MySQL returns an auth error; no need to restart mlrd.

`table_name` defaults to `ddb.table_name`.
This settings allows for a different MySQL table name.
Clients always reference table by `ddb.table_name`.

Other settings (`max_conn`, `storage`, etc.) are low-level and shouldn't be changed without consulting with mlrd.tech first.

`sharded` affects how BatchGetItem and BatchWriteItem work.
If false (default), SQL queries are optimized to run on a single node.
If true, SQL queries are modified to execute on multiple shards.
In the future, this setting will also affect TransactWriteItems and TransactGetItems.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="21">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">21</span><span class="setting">&nbsp;&nbsp;username: "mlrd"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="22">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">22</span><span class="setting">&nbsp;&nbsp;hostname: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="23">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">23</span><span class="setting">&nbsp;&nbsp;socket: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="24">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">24</span><span class="setting">&nbsp;&nbsp;password: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="25">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">25</span><span class="setting">&nbsp;&nbsp;password_file: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="26">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">26</span><span class="setting">&nbsp;&nbsp;db: "mlrd"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="27">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">27</span><span class="setting">&nbsp;&nbsp;table_name: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="28">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">28</span><span class="setting">&nbsp;&nbsp;tls:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="28" data-end-line="31">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 28-31</span>
          TLS
        </div>
        <div class="doc-content" style="z-index: 92;">
          <div class="doc-text">

Certificate authority (CA), certificate, and key files for TLS connection to MySQL.

`ca` can be defined alone.
`key` and `cert` must be defined together.

If no TLS is defined, a TLS-encrypted connection is still used (except for localhost and 127.0.0.1) but the sever identity is not verified.

mlrd auto-detects AWS RDS/Aurora hostnames and uses the AWS Global Certificate Authority (CA) automatically.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="29">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">29</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;ca: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="30">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">30</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;cert: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="31">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">31</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;key: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="32">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">32</span><span class="setting">&nbsp;&nbsp;aws:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="32" data-end-line="38">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 32-38</span>
          AWS RDS
        </div>
        <div class="doc-content" style="z-index: 91;">
          <div class="doc-text">

AWS RDS access if MySQL is an AWS RDS or Aurora instances.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="33">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">33</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;config_files: []</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="34">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">34</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;credentials_files: []</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="35">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">35</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;iam_auth: false</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="36">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">36</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;password_secret: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="37">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">37</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;profile: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="38">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">38</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;region: ""</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="39">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">39</span><span class="setting">&nbsp;&nbsp;max_conn: 100</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="40">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">40</span><span class="setting">&nbsp;&nbsp;max_conn_idle: 100</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="41">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">41</span><span class="setting">&nbsp;&nbsp;sharded: false</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="42">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">42</span><span class="setting">&nbsp;&nbsp;storage:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="42" data-end-line="45">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 42-45</span>
          Low-level Storage
        </div>
        <div class="doc-content" style="z-index: 90;">
          <div class="doc-text">

Consult with mlrd.tech before changing these settings.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="43">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">43</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;pk_len: 2048</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="44">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">44</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;sk_len: 1024</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="45">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">45</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;vgc: false</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="46">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">46</span><span class="setting"></span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="47">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">47</span><a name="metrics"><span class="setting">metrics:</span></a></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="47" data-end-line="55">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 47-55</span>
          OpenTelemetry Metrics
        </div>
        <div class="doc-content" style="z-index: 89;">
          <div class="doc-text">

Configures mlrd to send OpenTelemetry metrics.
To enable, set `endpoint`.

`freq` is a Go time duration string, minimum "1s" but default "5s" recommended.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="48">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">48</span><span class="setting">&nbsp;&nbsp;disable: false</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="49">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">49</span><span class="setting">&nbsp;&nbsp;endpoint: "127.0.0.1:4317"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="50">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">50</span><span class="setting">&nbsp;&nbsp;freq: "5s"</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="51">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">51</span><span class="setting">&nbsp;&nbsp;percentiles:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="51" data-end-line="53">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 51-53</span>
          Percentiles
        </div>
        <div class="doc-content" style="z-index: 88;">
          <div class="doc-text">

Percentiles to report for response time metrics.
Defaults shown: P50 (median) and P99.
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="52">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">52</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;- 50</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="53">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">53</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;- 99</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="54">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">54</span><span class="setting">&nbsp;&nbsp;sampling:</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="54" data-end-line="55">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Lines 54-55</span>
          Sampling Rate
        </div>
        <div class="doc-content" style="z-index: 87;">
          <div class="doc-text">

Sampling rates (currently only response time).
Values are every Nth:

- 100 = 1%
- 20 = 5%
- 10 = 10%
- 5 = 20%
- 4 = 25% (default)
- 2 = 50% 
- 1 = 100% (not recommended)
</div>
        </div>
      </div>
    </div>
  </div>
  <div class="line" data-line-num="55">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">55</span><span class="setting">&nbsp;&nbsp;&nbsp;&nbsp;response_time: 4</span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="56">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">56</span><span class="setting"></span></div>
    </div>
    <div class="doc-panel"></div>
  </div>
  <div class="line" data-line-num="57">
    <div class="yaml-section">
      <div class="yaml-line"><span class="line-number">57</span><span class="setting">disable: []</span></div>
    </div>
    <div class="doc-panel">
      <div class="doc-section" data-start-line="57" data-end-line="57">
        <div class="doc-header" onclick="toggleDoc(this)">
          <span class="doc-toggle">▶</span>
          <span class="doc-line-ref">Line 57</span>
          Disable Features
        </div>
        <div class="doc-content" style="z-index: 86;">
          <div class="doc-text">

List of [features]({{< ref "feature-flags" >}}) to disable.
Consult with mlrd.tech before setting.
</div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
function toggleDoc(header) {
  const content = header.nextElementSibling;
  const toggle = header.querySelector('.doc-toggle');

  if (content.classList.contains('expanded')) {
    content.classList.remove('expanded');
    toggle.classList.remove('expanded');
    header.classList.remove('expanded');
  } else {
    content.classList.add('expanded');
    toggle.classList.add('expanded');
    header.classList.add('expanded');
  }
}

// Highlight YAML lines when hovering over documentation
document.querySelectorAll('.doc-section').forEach(section => {
  section.addEventListener('mouseenter', function() {
    const startLine = parseInt(this.getAttribute('data-start-line'));
    const endLine = parseInt(this.getAttribute('data-end-line'));

    // Highlight all rows in the section range
    document.querySelectorAll('.line').forEach(row => {
      const lineNum = parseInt(row.getAttribute('data-line-num'));
      if (lineNum >= startLine && lineNum <= endLine) {
        const yamlSection = row.querySelector('.yaml-section');
        if (yamlSection) {
          yamlSection.style.background = 'var(--hl)';
        }
      }
    });
  });

  section.addEventListener('mouseleave', function() {
    const startLine = parseInt(this.getAttribute('data-start-line'));
    const endLine = parseInt(this.getAttribute('data-end-line'));

    // Remove highlight from all rows in the section range
    document.querySelectorAll('.line').forEach(row => {
      const lineNum = parseInt(row.getAttribute('data-line-num'));
      if (lineNum >= startLine && lineNum <= endLine) {
        const yamlSection = row.querySelector('.yaml-section');
        if (yamlSection) {
          yamlSection.style.background = '';
        }
      }
    });
  });
});
</script>
