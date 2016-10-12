function [warp_im] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A
A_inv = inv(A);
warp_im = zeros(out_size(1), out_size(2));
% for y = 1: out_size(1)
%     for x = 1: out_size(2)
%         des_index = A_inv(1:2,:) * [x;y;1];
%         des_index_round = round(des_index);
%         if des_index_round(1) > 0 &&  des_index_round(1) <= out_size(2) && des_index_round(2) > 0 && des_index_round(2) <= out_size(1)
%              warp_im(y, x) = im(des_index_round(2),des_index_round(1));
%         end
%        
%     end
% end
[A, B]= meshgrid(1:1:out_size(1),1:1:out_size(2));
coo_matr(1,:) = B(:);
coo_matr(2,:) = A(:);
coo_matr(3,:) = 1;
des_index = A_inv(1:2,:) * coo_matr;
des_index_round = round(des_index);
indexs_new = find(des_index_round(1,:) > 0 &  des_index_round(1,:)...
    <= out_size(2) & des_index_round(2,:) > 0 & des_index_round(2,:) <= out_size(1));
%source_index = des_index_round(:,indexs_new)'
%warp_im((floor(indexs_new/out_size(2)) + 1)',(mod(indexs_new, out_size(2)) + 1)') = im(source_index(:,2),source_index(:,1));
% mark = (x_coord_source > 0) & (x_coord_source < width) & (y_coord_source > 0) & (y_coord_source < height)
ind_warp = sub2ind(out_size, coo_matr(2,indexs_new), coo_matr(1,indexs_new));
ind_source = sub2ind(out_size, des_index_round(2, indexs_new), des_index_round(1, indexs_new));
warp_im(ind_warp) = im(ind_source);





        
        



