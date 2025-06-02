# Install required packages if not already installed
if (!require("data.tree")) install.packages("data.tree", dependencies = TRUE)
if (!require("DiagrammeR")) install.packages("DiagrammeR", dependencies = TRUE)

library(data.tree)
library(DiagrammeR)

# Create the decision tree structure
decision <- Node$new("Decision: Expand or Not")

# Option 1: Do Not Expand
no_expand <- decision$AddChild("Don't Expand")
no_expand_good <- no_expand$AddChild("Good Economy (45%)")
no_expand_bad <- no_expand$AddChild("Bad Economy (55%)")

# Expected payoffs
no_expand_good$AddChild("Revenue: $4M")
no_expand_bad$AddChild("Revenue: $1.5M")

# Option 2: Expand
expand <- decision$AddChild("Expand (-$2M Cost)")
expand_good <- expand$AddChild("Good Economy (45%)")
expand_bad <- expand$AddChild("Bad Economy (55%)")

# Expected payoffs
expand_good$AddChild("Revenue: $7M")
expand_bad$AddChild("Revenue: $3M")

# Plot the decision tree
SetGraphStyle(decision, rankdir = "LR")
SetEdgeStyle(decision, arrowhead = "vee", color = "gray35", penwidth = 2)
SetNodeStyle(decision, style = "filled,rounded", shape = "box", fillcolor = "lightblue", fontname = "Arial")

# Render tree
plot(decision)
