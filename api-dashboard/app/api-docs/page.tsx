'use client';

import { useState, useEffect } from 'react';
import axios from 'axios';

interface ApiEndpoint {
  name: string;
  path: string;
  methods: string[];
  description: string;
}

export default function ApiDocs() {
  const [endpoints, setEndpoints] = useState<ApiEndpoint[]>([
    {
      name: 'Titles',
      path: '/api/titles',
      methods: ['GET'],
      description: 'Get all titles from the database'
    },
    {
      name: 'GraphQL',
      path: '/graphql',
      methods: ['POST'],
      description: 'GraphQL endpoint for querying data'
    }
  ]);

  return (
    <main className="min-h-screen bg-gray-100 py-8">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="bg-white shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <h1 className="text-2xl font-bold text-gray-900 mb-6">Data API Builder Endpoints</h1>
            
            <div className="space-y-6">
              {endpoints.map((endpoint) => (
                <div key={endpoint.path} className="border rounded-lg p-4">
                  <div className="flex items-center justify-between">
                    <h2 className="text-lg font-semibold text-gray-900">{endpoint.name}</h2>
                    <div className="flex space-x-2">
                      {endpoint.methods.map((method) => (
                        <span
                          key={method}
                          className={`px-2 py-1 text-xs font-medium rounded-full ${
                            method === 'GET'
                              ? 'bg-green-100 text-green-800'
                              : method === 'POST'
                              ? 'bg-blue-100 text-blue-800'
                              : 'bg-gray-100 text-gray-800'
                          }`}
                        >
                          {method}
                        </span>
                      ))}
                    </div>
                  </div>
                  <p className="mt-2 text-sm text-gray-600">{endpoint.description}</p>
                  <div className="mt-4">
                    <code className="block bg-gray-50 p-2 rounded text-sm text-gray-800">
                      {endpoint.path}
                    </code>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </main>
  );
} 