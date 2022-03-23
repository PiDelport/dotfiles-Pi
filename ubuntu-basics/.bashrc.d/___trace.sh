___trace () {
    tmux new-session -d 'mtr --displaymode 2 1.1.1.1'
    tmux split-window -v 'mtr --displaymode 2 8.8.8.8'
    tmux set mouse on
    tmux attach
}
