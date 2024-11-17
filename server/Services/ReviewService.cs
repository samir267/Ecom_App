using System.Collections.Generic;
using System.Threading.Tasks;
using server.Models;
using server.Repositories;

namespace server.Services
{
    public class ReviewService
    {
        private readonly ReviewRepository _reviewRepository;

        public ReviewService(ReviewRepository reviewRepository)
        {
            _reviewRepository = reviewRepository;
        }

        public async Task<IEnumerable<ReviewModel>> GetReviewsByProductIdAsync(int productId)
        {
            return await _reviewRepository.GetReviewsByProductIdAsync(productId);
        }

        public async Task<ReviewModel> AddReviewAsync(ReviewModel review)
        {
            return await _reviewRepository.AddReviewAsync(review);
        }

        public async Task<bool> DeleteReviewAsync(int id)
        {
            return await _reviewRepository.DeleteReviewAsync(id);
        }
    }
}
