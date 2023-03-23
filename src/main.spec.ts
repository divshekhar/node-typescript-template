import request from 'supertest';
import app from './main';

describe('Hello World API', () => {
  it('Should GET / 200 OK', (done: jest.DoneCallback) => {
    request(app)
      .get('/')
      .expect(response => {
        expect(response.statusCode).toBe(200);
        expect(response.text).toBe('Hello world');
      })
      .end(done);
  });
});
