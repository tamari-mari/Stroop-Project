library(ggplot2)


stroop_data <- data.frame(
  condition = c("Congruent", "Incongruent"),
  reaction_time = c(650, 800)
)

ggplot(stroop_data, aes(x = condition, y = reaction_time)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(
    title = "Stroop Reaction Time",
    x = "Condition",
    y = "Average RT (ms)"
  ) +
  theme_minimal()


ggsave("stroop_results.png", width = 6, height = 4)
