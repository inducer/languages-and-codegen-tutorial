void transpose(
  __global float *a_t, __global float *a,
  unsigned a_width, unsigned a_height)
{
  int base_idx_a   =
    get_group_id(0) * BLK_SIZE +
    get_group_id(1) * A_BLOCK_STRIDE;
  int base_idx_a_t =
    get_group_id(1) * BLK_SIZE +
    get_group_id(0) * A_T_BLOCK_STRIDE;

  int glob_idx_a =
    base_idx_a + get_local_id(0) 
    + a_width * get_local_id(1);
  int glob_idx_a_t = 
    base_idx_a_t + get_local_id(0) 
    + a_height * get_local_id(1);

  __local float a_local[BLK_SIZE][BLK_SIZE+1];

  a_local[get_local_id(1)*BLK_SIZE+get_local_id(0)] = 
    a[glob_idx_a];

  barrier(CLK_LOCAL_MEM_FENCE);

  a_t[glob_idx_a_t] = 
    a_local[get_local_id(0)*BLK_SIZE+get_local_id(1)];
}
