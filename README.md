# dbt Learning Journey 

This repository documents my hands-on journey of learning **dbt (Data Build Tool)** with **Databricks**, **Git**, **GitHub**, and modern data engineering practices.

Rather than only building models, I wanted to understand **how dbt works internally**, how it integrates with a data warehouse, and how professional data engineering projects are structured.

This project represents not only my technical progress but also the mistakes I made, the problems I solved, and the lessons I learned along the way.

---

# Project Overview

This project includes:

- Bronze, Silver and Gold data layers
- Sources
- Materializations
- Generic Tests
- Custom Generic Tests
- Seeds
- Analyses
- Jinja
- Macros
- Snapshots
- Deployment to different environments
- Git workflow
- Databricks integration

Final build summary:

```
PASS = 18
WARN = 0
ERROR = 0
SKIP = 0
```

Everything builds successfully using:

```bash
dbt build
```

---

# What is dbt?

dbt (Data Build Tool) is an analytics engineering framework that transforms raw data already stored inside a data warehouse into clean, tested and documented datasets.

Unlike traditional ETL tools, dbt focuses only on the **Transform** part of ELT.

Instead of moving data, dbt allows you to write modular SQL models which are then compiled and executed inside the warehouse itself.

It brings software engineering practices into analytics engineering by providing:

- Version control
- Modular SQL
- Testing
- Documentation
- Reusable code
- Environment management
- CI/CD compatibility

---

# My Understanding of dbt

After completing this project, this is how I understand dbt.

Raw data usually lands inside a warehouse like Databricks.

dbt sits on top of that warehouse.

Instead of manually writing hundreds of SQL scripts, dbt allows us to build transformations as independent models.

Those models are connected together through dependency graphs using:

```sql
{{ ref('model_name') }}
```

instead of hardcoded table names.

This makes projects:

- reusable
- maintainable
- environment independent

dbt then compiles all of these SQL models and executes them inside Databricks.

Because dbt understands model dependencies, it automatically builds objects in the correct order.

I also learned that dbt is much more than SQL.

It provides:

- Testing
- Documentation
- Snapshots
- Seeds
- Macros
- Jinja templating
- Environment management
- Incremental builds
- Deployment support

This makes dbt closer to a software engineering framework than simply a SQL tool.

---

# Concepts I Learned

## Project Structure

- dbt_project.yml
- models/
- macros/
- analyses/
- snapshots/
- tests/
- seeds/
- target/

---

## Data Layers

### Bronze

Raw cleaned source tables.

### Silver

Business transformations and joins.

### Gold

Business-ready reporting models.

---

## Sources

Instead of querying raw tables directly, I learned to define sources inside:

```yaml
sources.yml
```

and reference them using

```sql
{{ source('source','table') }}
```

instead of hardcoding database names.

---

## ref()

One of the most important concepts.

Instead of writing

```sql
select *
from dbt_tutorial_dev.bronze.customer
```

I learned to write

```sql
select *
from {{ ref('bronze_customer') }}
```

This automatically manages dependencies.

---

## Materializations

I learned different materializations such as:

- Table
- View

and how configuration precedence works:

1. SQL config block
2. properties.yml
3. dbt_project.yml

---

## Testing

Implemented:

- unique
- not_null
- accepted_values
- custom generic tests

which automatically validate data quality during every build.

---

## Seeds

Loaded CSV files into Databricks using

```bash
dbt seed
```

and referenced them using

```sql
{{ ref('mapping') }}
```

---

## Jinja & Macros

One of the most interesting parts of dbt.

I learned how SQL can become dynamic using Jinja.

Examples included:

- loops
- variables
- conditions

I also created reusable macros to reduce repeated SQL.

---

## Snapshots

Learned how dbt tracks historical changes over time.

Instead of overwriting records, snapshots preserve historical versions of data.

---

## Deployment

Configured both:

- Development
- Production

profiles and learned how environment switching works.

---

# Git Learning Journey

This project also became my first serious Git learning experience.

I learned how to:

- initialize repositories
- create branches
- merge feature branches
- resolve merge conflicts
- push local repositories to GitHub
- understand remotes
- manage Git history

Some Git commands I became comfortable with:

```bash
git init
git add .
git commit
git branch
git switch
git merge
git pull
git push
git remote
```

---

# Problems I Faced

## 1. Authentication Failed

When pushing to GitHub I received:

```
Invalid username or token.
Password authentication is not supported.
```

### What I learned

GitHub no longer accepts account passwords.

Authentication now requires:

- Personal Access Tokens
- SSH Keys
- GitHub CLI

I generated a Personal Access Token and successfully authenticated.

---

## 2. Non-fast-forward Push

After creating a repository with a README, Git refused my push.

I learned that:

My local repository and GitHub repository had different commit histories.

The fix was understanding how remote history works and recreating the repository correctly.
![alt text](<Screenshot 2026-07-03 at 2.47.14 pm.png>)

---

## 3. Existing Remote

I also encountered:

```
remote origin already exists
```

I learned that deleting a GitHub repository does not remove the remote configuration from my local repository.

I learned how to:

```bash
git remote remove origin

git remote set-url origin
```

---

# My Biggest Mistake (and Lesson)

Initially I copied my:

```
profiles.yml
```

inside my project folder and committed it to Git.

That file contained my Databricks access token.

GitHub Push Protection immediately blocked my push because it detected a secret.

The error explained that sensitive credentials should never be committed.

This was a valuable lesson in security.

### What I changed

I:

- revoked the exposed Databricks token
- generated a new token
- removed the secret from my project
- replaced it with a safe template file

```
profiles_example.yml
```

This allows anyone to understand the required configuration without exposing private credentials.

I also learned that the real:

```
~/.dbt/profiles.yml
```

should remain local and should never be committed to Git.

---

# Final Build

After fixing all Git issues and dbt configuration, the project builds successfully.

```
Completed successfully

PASS = 18
WARN = 0
ERROR = 0
SKIP = 0
```
![alt text](<Screenshot 2026-07-03 at 2.52.56 pm.png>)

This confirmed that:

- models compile correctly
- tests pass
- seeds load
- snapshots run
- dependencies resolve correctly

---

# Key Takeaways

This project taught me much more than writing SQL.

I learned:

- Analytics Engineering principles
- dbt architecture
- Databricks integration
- Software engineering workflows
- Git and GitHub
- Security best practices
- Environment management
- Testing and validation
- Modular SQL development

Most importantly, I learned that mistakes are part of the development process.

Every Git error, merge conflict, authentication issue, and secret scanning failure improved my understanding of how professional development workflows actually work.

---

## Technologies Used

- dbt Core
- Databricks
- SQL
- Jinja
- Python
- Git
- GitHub
- uv