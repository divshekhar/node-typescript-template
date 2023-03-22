import request from 'supertest';
import app from './main';

describe('Hello World API', () => {
  it('Should GET / 200 OK', async () => {
    const response = await request(app).get('/');
    expect(response.status).toBe(200);
    expect(response.text).toBe('Hello world');
  });
});
