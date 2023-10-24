# contents

## git semantic versioning bash scripts

### automatically generate next

Will prompt the user propousing the next tag, then will apply it, and push.

[see script](next_git_tag.sh)

### prune old tags

Script usage.

If passed first parameter must be the lower tag to preserve, must be an integer.

If no argument passed the user will be prompted for confirmation for any tag in the repository.

This solution is more secure than dealing on tag date, since could not be consistent with version progression.

[see script](prune_git_tags.sh)

