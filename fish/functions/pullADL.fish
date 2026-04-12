function pullADL
    rclone sync "ADL FP:Colab Notebooks/ADL Homework/Final Project" $HOME/Desktop/coursework/s26/ADL/FP/ --fast-list
end
