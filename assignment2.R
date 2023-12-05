##1使用R中的数据读写，文件路径，for循环语句，读入路径“/assignment_idaccuracy/Aminer”总的所有文件，并将数据合并成为一个data.frame输出
# 设置文件夹路径
folder_path <- "E:/bigd_eco/assignment_idaccuracy/Aminer"

# 获取文件夹中的所有文件
files <- list.files(folder_path, full.names = TRUE)

# 初始化一个空的数据框
merged_df <- data.frame()
# 使用for循环读取每个文件并合并到数据框中
for (file in files) {
  current_data <- read.csv(file, header = TRUE, stringsAsFactors = FALSE, na.strings = "", fill = TRUE)
  merged_df <- rbind(merged_df, current_data)
}
# 打印合并后的数据框
print(merged_df)

# 输出数据摘要
summary(merged_df)

#输出数据框merged_df到新的csv文件
write.csv(merged_df, file = "E:/bigd_eco/assignment_idaccuracy/Aminer/merged.csv", row.names = FALSE)

#2用apply家族函数代替上面的for循环
# 设置文件夹路径
folder_path <- "E:/bigd_eco/assignment_idaccuracy/Aminer"

# 获取文件夹中的所有文件
files <- list.files(folder_path, full.names = TRUE)

# 使用lapply读取所有文件并合并为一个列表
data_list <- lapply(files, function(file) {
  read.csv(file, header = TRUE, stringsAsFactors = FALSE, na.strings = "", fill = TRUE)
})
# 合并列表中的所有数据框为一个数据框
merged_df <- do.call(rbind, data_list)

# 打印合并后的数据框
print(merged_df)
# 输出数据摘要
summary(merged_df)

#输出数据框merged_df到新的csv文件
write.csv(merged_df, file = "E:/bigd_eco/assignment_idaccuracy/Aminer/merged.csv", row.names = FALSE)



##3将2中代码封装成为一个可以在命令行运行的脚本，脚本的唯一一个参数为aminer论文文件所在的路径

# 获取命令行参数
args <- commandArgs(trailingOnly = TRUE)

# 定义预期的文件路径
expected_path <- "E:/bigd_eco/assignment_idaccuracy/Aminer"

# 检查是否有传递参数
if (length(args) == 0) {
  cat("请输入文件路径作为参数。\n")
} else {
  # 检查输入的文件路径是否匹配预期路径
  if (identical(args[1], expected_path)) {
    # 获取文件夹中的所有文件
    files <- list.files(args[1], full.names = TRUE)
    
    # 使用lapply读取所有文件并合并为一个列表
    data_list <- lapply(files, function(file) {
      read.csv(file, header = TRUE, stringsAsFactors = FALSE, na.strings = "", fill = TRUE)
    })
    
    # 合并列表中的所有数据框为一个数据框
    merged_df <- do.call(rbind, data_list)
    
    # 打印新的数据框
    print(merged_df)
    
    # 输出数据摘要
    summary(merged_df)
  } else {
    cat("请输入正确的文件路径。\n")
  }
}
