# contents

## bash script to automatically prune old tags from a git repository following semantic versioning

Script usage.

If passed first parameter must be the lower tag to preserve, must be an integer.

If no argument passed the user will be prompted for confirmation for any tag in the repository.

This solution is more secure than dealing on tag date, since could not be consistent with version progression.

[see script](prune_git_tags.sh)

