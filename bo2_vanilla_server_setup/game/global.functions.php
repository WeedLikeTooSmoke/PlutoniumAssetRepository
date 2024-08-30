<?php

function sortRank($rank) {
    switch ($rank) {
        case 0;
        return "PLAYER";
        break;
        case 1;
        return "VIP";
        break;
        case 2;
        return "MOD";
        break;
        case 3;
        return "ADMIN";
        break;
        case 4;
        return "OWNER";
        break;
    }
}