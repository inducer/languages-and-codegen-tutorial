__global__ void transpose(
    float *A_t, float *A,
    int a_width, int a_height)
{
  int base_idx_a   =
    blockIdx.x * BLK_SIZE +
    blockIdx.y * A_BLOCK_STRIDE;
  int base_idx_a_t =
    blockIdx.y * BLK_SIZE +
    blockIdx.x * A_T_BLOCK_STRIDE;

  int glob_idx_a =
    base_idx_a + threadIdx.x
    + a_width * threadIdx.y;
  int glob_idx_a_t =
    base_idx_a_t + threadIdx.x
    + a_height * threadIdx.y;

  __shared__ float A_shared[BLK_SIZE][BLK_SIZE+1];

  A_shared[threadIdx.y][threadIdx.x] =
    A[glob_idx_a];

  __syncthreads();

  A_t[glob_idx_a_t] =
    A_shared[threadIdx.x][threadIdx.y];
}
