# CoffeeApp

Branches:
- IOS - Staging
- IOS - Production

- Node - Staging
- Node - Production
---

# Guidelines til git:
Push til branch
---
Først tilføjer du alle ændringer til dit commit:
git add .

Så commiter du det:
git commit -m "commit message in english"

Så pusher du til den rigtige branch (DER PUSHES KUN TIL STAGING):
git push origin <branch_name>

Skift branch
---
Sørg for at alle ændringer er pushet først!
'''git checkout <branch_name>'''

For ios - kør pod install efter

Push fra staging til production branch
---
Sørg for at staging branch er up-to-date og testet på de respektive udvikleres computere, før der pushes til production branch!

git push origin <staging_branch>:<production_branch>


