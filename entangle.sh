echo -e "\033[0;35m"
echo  " ========================================================";
echo  "        _ _ _        _ _ _ _ _       _ _ _ _ _                           ";
echo  "      /  /\  \      |  _ _ _ _|    /    _ _ _ |                          ";
echo  "     /  /  \  \     |  |_ _ _ _   |   /                                  ";
echo  "    /  /_ _ \  \    |_ _ __   |   |  |                                   ";
echo  "   /  /_ _ _ \  \    _ _ __|  |   |   \_ _ _ _                           ";
echo  "  /_ /        \ _\  |_ _ _ _ _|    \ _ _ _ _ _|                          ";
echo -e "\e[35m"
echo "=========================================================="
echo -e '\e[35mNode :\e[35m' Entangle Node
echo -e '\e[35mTelegram Group :\e[35m' @autosultan_group
echo -e '\e[35mTelegram Channel :\e[35m' @airdropasc
echo "=========================================================="
echo -e "\e[0m"

sleep 2

echo -e "\e[1m\e[32m Install Bahan \e[0m" && sleep 1
sudo apt -q update

sudo apt -qy install curl git jq lz4 build-essential

sudo apt -qy upgrade

echo -e "\e[1m\e[32m Clone Repo \e[0m" && sleep 1
git clone https://github.com/Entangle-Protocol/entangle-blockchain

echo '=============== DONE ==================='
