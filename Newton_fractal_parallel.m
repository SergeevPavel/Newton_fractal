% Plotting Newton's fractal for equation z^n = 1.
function Newton_fractal_parallel(n, minRe, maxRe, minIm, maxIm, xResolution, yResolution)
maxIteration = 100;
eps = 10e-5;
Roots = exp((0:(n-1)) * (2 * pi) * 1i / n);
Image = zeros(yResolution, xResolution, 3);
dRe = (maxRe - minRe) / (xResolution - 1);
dIm = (maxIm - minIm) / (yResolution - 1);
parfor i = 1:yResolution
    for j = 1:xResolution
        z = minRe + (j - 1) * dRe + (minIm + (i - 1) * dIm) * 1i;
        for iteration = 1:maxIteration
            delta = z * (z^(-n) - 1) / n;
            z = z + delta;
            if (abs(delta) < eps)
                break;
            end
        end
        [err, k] = min(abs(Roots - z));
        if (err <= eps)
            Image(i, j, :) = [(k - 1) / n, 1, 1 - iteration / maxIteration];
        else
            Image(i, j, :) = 0;
        end
    end
end
image(hsv2rgb(Image));
end