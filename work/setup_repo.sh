#!/bin/bash
set -e

echo "=== Git Learning Project Setup Script ==="
echo "This script will create the complete Git learning project with all 12 exercises"
echo

# Create the main work directory structure
mkdir -p work/hello/lib
cd work/hello

echo "=== Exercise 1: Setting Up Git ==="
git init
git config user.name "John Doe"
git config user.email "john.doe@example.com"
echo "✓ Git repository initialized and configured"

echo
echo "=== Exercise 2: Git Commits ==="
# Initial hello.sh
echo 'echo "Hello, World"' > hello.sh
git add hello.sh
git commit -m "Initial commit"

# Add shebang and parameter
cat > hello.sh << 'EOF'
#!/bin/bash
echo "Hello, $1"
EOF
git add hello.sh
git commit -m "Add shebang and parameter support"

# Add default parameter with comment
cat > hello.sh << 'EOF'
#!/bin/bash
# Default is "World"
name=${1:-"World"}
echo "Hello, $name"
EOF
git add hello.sh
git commit -m "Add default parameter and comment"

echo "✓ Created hello.sh with progressive commits"

echo
echo "=== Exercise 3: History ==="
echo "History commands to run:"
echo "git log"
echo "git log --oneline"
echo "git log --pretty=format:'* %h %ad | %s%d [%an]' --graph --date=short -2"
echo "git log --since='5 minutes ago'"

echo
echo "=== Exercise 4: Check it out ==="
echo "Commands to navigate history:"
echo "git checkout HEAD~2  # First snapshot"
echo "git checkout HEAD~1  # Second snapshot"
echo "git checkout main    # Latest version"

echo
echo "=== Exercise 5: TAG me ==="
git tag v1
git tag v1-beta HEAD~1
echo "✓ Created tags v1 and v1-beta"

echo
echo "=== Exercise 6: Changed your mind? ==="
# Add bad comment
cat > hello.sh << 'EOF'
#!/bin/bash
# This is a bad comment. We want to revert it.
name=${1:-"World"}
echo "Hello, $name"
EOF
git add hello.sh
git commit -m "Add bad comment"
git tag oops

# Reset to v1 and add proper author comment
git reset --hard v1
cat > hello.sh << 'EOF'
#!/bin/bash
# Default is World
# Author: Jim Weirich
name=${1:-"World"}
echo "Hello, $name"
EOF
git add hello.sh
git commit --amend -m "Add default parameter and comment with author"

echo "✓ Reverted bad changes and added author comment"

echo
echo "=== Exercise 7: Move it ==="
git mv hello.sh lib/hello.sh

cat > Makefile << 'EOF'
TARGET="lib/hello.sh"
run:
	bash ${TARGET}
EOF
git add Makefile
git commit -m "Move hello.sh to lib directory and add Makefile"

echo "✓ Moved hello.sh to lib/ and created Makefile"

echo
echo "=== Exercise 8: Blobs, trees and commits ==="
echo "Git objects exploration commands:"
echo "find .git/objects -type f | head -5"
echo "git cat-file -t <hash>"
echo "git cat-file -p <hash>"
echo "git ls-tree HEAD"

echo
echo "=== Exercise 9: Branching ==="
git checkout -b greet

# Create greeter.sh
cat > lib/greeter.sh << 'EOF'
#!/bin/bash
Greeter() {
    who="$1"
    echo "Hello, $who"
}
EOF
git add lib/greeter.sh
git commit -m "Add greeter function"

# Update hello.sh to use greeter
cat > lib/hello.sh << 'EOF'
#!/bin/bash
source lib/greeter.sh
name="$1"
if [ -z "$name" ]; then
    name="World"
fi
Greeter "$name"
EOF
git add lib/hello.sh
git commit -m "Update hello.sh to use greeter function"

# Update Makefile
cat > Makefile << 'EOF'
TARGET="lib/hello.sh"
run:
	bash ${TARGET}
EOF
git add Makefile
git commit -m "Update Makefile for new hello.sh structure"

# Switch to main and add README
git checkout main
cat > README.md << 'EOF'
This is the Hello World example from the git project.
EOF
git add README.md
git commit -m "Add README.md"

echo "✓ Created greet branch with greeter functionality"

echo
echo "=== Exercise 10: Conflicts, merging and rebasing ==="
# Merge main into greet
git checkout greet
git merge main

# Switch to main and create conflicting change
git checkout main
cat > lib/hello.sh << 'EOF'
#!/bin/bash
echo "What's your name"
read my_name
echo "Hello, $my_name"
EOF
git add lib/hello.sh
git commit -m "Change hello.sh to interactive version"

# Switch back to greet and attempt merge (will conflict)
git checkout greet
# This will create a conflict, so we'll resolve it by accepting main's version
git merge main || true

# Resolve conflict by accepting main's version
git checkout --theirs lib/hello.sh
git add lib/hello.sh
git commit -m "Resolve conflict by accepting main's interactive version"

# Rebase greet on main
git rebase main

# Merge greet into main
git checkout main
git merge greet

echo "✓ Demonstrated merging, conflicts, and rebasing"

echo
echo "=== Exercise 11: Local and remote repositories ==="
cd ../../  # Go back to work directory

# Clone the repository
git clone hello cloned_hello
cd cloned_hello

echo "✓ Cloned repository as cloned_hello"

# Go back to original and update README
cd ../hello
cat > README.md << 'EOF'
This is the Hello World example from the git project. (changed in the original)
EOF
git add README.md
git commit -m "Update README in original repository"

echo "✓ Updated README in original repository"

echo
echo "=== Exercise 12: Bare repositories ==="
cd ../  # Back to work directory

# Create bare repository
git clone --bare hello hello.git

# Add bare repository as remote to original
cd hello
git remote add shared ../hello.git

# Update README and push to shared
cat > README.md << 'EOF'
This is the Hello World example from the git project. (Changed in the original and pushed to shared)
EOF
git add README.md
git commit -m "Update README for shared repository"
git push shared main
git push shared greet

# Pull changes in cloned repository
cd ../cloned_hello
git remote add shared ../hello.git
git fetch shared
git merge shared/main

echo "✓ Created bare repository and demonstrated remote operations"

echo
echo "=== Project Setup Complete ==="
echo "All 12 exercises have been implemented with proper Git history"
echo "Repository structure:"
cd ../
tree -a -I '.git'

echo
echo "=== Final Git Status ==="
cd hello
echo "Current branch and status:"
git branch -a
git status

echo
echo "=== Commit History ==="
git log --graph --all --decorate --oneline

echo
echo "=== Tags ==="
git tag

echo
echo "Project setup completed successfully!"
echo "All deliverables are ready for Gitea repository upload."
