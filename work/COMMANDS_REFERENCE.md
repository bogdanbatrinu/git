# Git Commands Reference - Complete Exercise Guide

This document provides all the Git commands used throughout the 12 exercises, organized by exercise for easy reference during audits.

## Exercise 1: Setting Up Git

```bash
# Initialize repository
git init

# Configure Git
git config user.name "John Doe"
git config user.email "john.doe@example.com"

# Verify configuration
git config --list
```

## Exercise 2: Git Commits

```bash
# Check repository status
git status

# Stage files
git add hello.sh

# Commit changes
git commit -m "Initial commit"
git commit -m "Add shebang and parameter support"
git commit -m "Add default parameter and comment"
```

## Exercise 3: History

```bash
# Show full commit history
git log

# Show one-line history
git log --oneline

# Show last 2 entries with custom format
git log --pretty=format:'* %h %ad | %s%d [%an]' --graph --date=short -2

# Show commits from last 5 minutes
git log --since='5 minutes ago'

# Show commits with graph
git log --graph --all --decorate --oneline
```

## Exercise 4: Check it out

```bash
# Navigate to first snapshot
git checkout HEAD~2

# Navigate to second snapshot  
git checkout HEAD~1

# Return to latest version
git checkout master
```

## Exercise 5: TAG me

```bash
# Create tag for current version
git tag v1

# Create tag for previous version
git tag v1-beta HEAD~1

# Navigate to tagged versions
git checkout v1
git checkout v1-beta

# List all tags
git tag
```

## Exercise 6: Changed your mind?

```bash
# Reset to specific commit/tag
git reset --hard v1

# Amend last commit
git commit --amend -m "New message"

# Tag before destructive operations
git tag oops
```

## Exercise 7: Move it

```bash
# Move files with Git
git mv hello.sh lib/hello.sh

# Add new files
git add Makefile

# Commit file moves
git commit -m "Move hello.sh to lib directory and add Makefile"
```

## Exercise 8: Blobs, trees and commits

```bash
# Explore .git directory
find .git/objects -type f

# Examine Git objects
git cat-file -t <hash>       # Show object type
git cat-file -p <hash>       # Show object content

# Show tree structure
git ls-tree HEAD
```

## Exercise 9: Branching

```bash
# Create and switch to new branch
git checkout -b greet

# Switch between branches
git checkout master
git checkout greet

# List branches
git branch
git branch -a                # Include remote branches

# Compare branches
git diff master greet
```

## Exercise 10: Conflicts, merging and rebasing

```bash
# Merge branches
git merge master             # Merge master into current branch

# Handle merge conflicts
git checkout --theirs file   # Accept their version
git add conflicted_file
git commit                   # Complete merge

# Show merge/rebase status
git status
git log --graph --oneline
```

## Exercise 11: Local and remote repositories

```bash
# Clone repository
git clone hello cloned_hello

# Show remote information
git remote -v

# List all branches
git branch -a

# Fetch from remote
git fetch origin

# Merge remote changes
git merge origin/master

# Add remote repository
git remote add shared ../hello.git
```

## Exercise 12: Bare repositories

```bash
# Create bare repository
git clone --bare hello hello.git

# Add bare repository as remote
git remote add shared ../hello.git

# Push to bare repository
git push shared master
git push shared greet

# Fetch from bare repository
git fetch shared
git merge shared/master
```

## Key Commands Summary

### Essential Daily Commands
```bash
git status                   # Check working tree status
git add .                    # Stage all changes
git commit -m "message"      # Commit with message
git push                     # Push to remote
git pull                     # Fetch and merge from remote
```

### History and Navigation
```bash
git log --oneline            # Compact history
git log --graph --all        # Visual branch history
git checkout <commit/branch> # Navigate to commit/branch
git diff                     # Show changes
```

### Branching
```bash
git branch                   # List branches
git checkout -b <branch>     # Create and switch to branch
git merge <branch>           # Merge branch
git branch -d <branch>       # Delete branch
```

### Remote Operations
```bash
git clone <url>              # Clone repository
git remote -v                # Show remotes
git fetch                    # Fetch changes
git push origin <branch>     # Push branch to remote
```

This reference covers all commands used in the Git learning project exercises.
