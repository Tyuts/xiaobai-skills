# Design Review

This document records the creator/reviewer discussion behind 小白 Skills.

## Creator View

Beginners need a good default, not a giant marketplace.

The first-run experience should answer:

- What should I install first?
- Which skills cover everyday work?
- What happens when two skills overlap?
- How do I undo a choice later?

The skill should therefore provide:

- a recommended starter set
- an installer script
- a curation workflow
- a backup folder convention
- a written inventory
- acknowledgements for upstream projects

## Reviewer View

The risky part is overreach. A "starter pack" can become a noisy global mess if
it installs every impressive workflow framework.

The skill must defend against:

- duplicate trigger surfaces
- broad workflow packs fighting each other
- dangerous or auto-approval instructions becoming global defaults
- hidden deletion of user-installed skills
- missing restore instructions
- missing upstream attribution

## Final Decisions

- Keep Matt Pocock's skills as the default engineering workflow family.
- Keep gstack and Superpowers as backup frameworks, not default global installs.
- Keep frontend-master as the default frontend specialist.
- Keep Baoyu skills for content/media utilities, but move danger/redundant
  subskills to backup during curation.
- Keep system skills and find-skills global.
- Create a manifest every time curation runs.
- Never delete skills during curation unless the user explicitly asks.

