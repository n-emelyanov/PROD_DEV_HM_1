#!/bin/bash

# master start + tag 0.1
git init
git add .
./create_commit.sh init.txt
git tag 0.1

# develop first commit
git checkout -b develop
./create_commit.sh develop_1.txt

# feature_1
git checkout -b feature/feature-1 develop
./create_commit.sh feature_1_1.txt

# feature_2
git switch develop
git checkout -b feature/feature-2 develop
./create_commit.sh feature_2_1.txt
./create_commit.sh feature_2_2.txt

# hotfix (критический баг) + master tag 0.2
git checkout -b hotfix/critical master
./create_commit.sh hotfix_critical.txt

git switch master
git merge hotfix/critical --no-ff -m "Merge hotfix/critical into master"
git tag 0.2

git switch develop
git merge hotfix/critical --no-ff -m "Merge hotfix/critical into develop"

# merge в feature 1.0 и обратно
git switch feature/feature-1
git merge develop -m "Merge feature/feature-1 into develop"
./create_commit.sh feature1_3.txt

git switch develop
git merge feature/feature-1 --no-ff -m "Merge feature/feature-1 into develop"

# release_1
git checkout -b release/1.0 develop

# back to the develop (4)
git switch develop
./create_commit.sh develop_4.txt

# feature_3 
git checkout -b feature/feature-3
./create_commit.sh feature_3_2.txt

# release 2
git switch release/1.0 
./create_commit.sh release_1.txt

# master tag 1.0
git switch master
git merge release/1.0 --no-ff -m "Merge release/1.0 into master"
git tag 1.0

# dev 5 (after release 2)
git switch develop
git merge release/1.0 --no-ff -m "Merge release/1.0 into develop"

# feature_3 (6) merge dev
git switch feature/feature-3
git merge develop --no-ff -m "Merge develop into feature/feature-3"
./create_commit.sh feature_3_4.txt


# 2 commits in feature_2
git switch feature/feature-2
./create_commit.sh feature_2_3.txt
./create_commit.sh feature_2_4.txt

# dev last commit
git switch develop
git merge feature/feature-3 --no-ff -m "Merge feature/feature-3 into develop"
git merge feature/feature-2 --no-ff -m "Merge feature/feature-2 into develop"

# release last commit (merge)
git switch release/1.0
git merge develop --no-ff -m "Merge develop into release/1.0 for finalization"

# master last commit
git switch master
git merge release/1.0 --no-ff -m "Merge release/1.0 into master"
