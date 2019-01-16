function hit = Collision(bombX, bombY, enX, enY)

% Check if the bomb has hit the opponent
if ((bombX > enX-15) && (bombX < 15 + enX) ) && ((bombY > enY-15) && (bombY < 15 + enY))
    didHit = 1;     
else
    didHit = 0;     
end

if (didHit == 1)
    hit = 1;        %return true if it has
else
    hit = 0;      %return false if it hasn't
end

end