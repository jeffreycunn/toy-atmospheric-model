function [th, thm, pim, pic, pprt] = cmm_init(xs, g, nx, nz, zu, dx, dz, zcnt, xcnt, radz, radx, trigpi, cp, rhou, tb, qb, thermamp, th, thm, pim, pic, pprt, bubble_switch)
  if bubble_switch == 1
      for i = 2:nx-1
          for k = 2:nz-1
              rad = sqrt(((zu[k]-zcnt)/radz)^2 + ((xs[i]-xcnt)/radx)^2)
              if rad <= 1.0
                  th[i,k] = 0.5*thermamp*(1.0 + cos(rad*trigpi))
              else
                  th[i,k] = 0.0
              end
              thm[i,k] = th[i,k]
          end
          thm[i,1] = thm[i,2]
          th[i,1] = th[i,2]
      end
      for i = 2:nx-1
          pic[i,nz-1] = 0.0
          for k = nz-2:-1:2
              tup = th[i,k+1]/(tb[k+1]^2)
              tdn = th[i,k]/(tb[k]^2)
              pic[i,k] = pic[i,k+1] - (g/cp)*0.5*(tup+tdn)*dz
              pim[i,k] = pic[i,k]
          end
          pic[i,1] = pic[i,2]
          pim[i,1] = pim[i,2]
      end
  elseif bubble_switch == 0
      th[:,:] .= 0
      thm[:,:] .= 0
  end
end
