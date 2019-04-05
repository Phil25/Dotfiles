#!/bin/bash

urxvt -title TODOList -e sh -c "markdown ~/Notes/todo_notes.md | w3m -T text/html"
